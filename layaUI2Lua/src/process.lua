--[[
    . 提示输入模块目录名 如：activityModule，默认活动目录;    
    . 提示输入文件名字，比如 HahaPanle
    . 在lua工程下创建lua模板文件，包含方法autoUI(),生成的代码会替换这个函数
    . 在LayaAir编辑器中创建ui模板文件
    . 将ui文件导出到lua代码中（替换autoUI方法）

    ui文件结构和lua文件结构是对应的
    uiDir/AbcModule.ui 在转换后会复制到 SrcModuleDir/xxxModule/AbcModule.lua
    uiDir/BbbPanle.ui 在转换后会复制到 SrcModuleDir/xxxModule/panel/AaaPanle.lua
    其他的则会复制到 SrcModuleDir/xxxModule/view/AaaCell.lua
]] 

module(..., package.seeall)


local lfs = require("lfs")
local json = require("json")

-- local md5 = require("md5")
local ResDir = PathCfg.codePorj.res

local strFmt_ = string.format
local dump = kit.dump

local LangTab = {}
local function _setLangTab()
    local url = ResDir .. "/config/common/languageconfig.lua"
    local lang = dofile(url)

    for k, v in pairs(lang) do
        v = string.gsub(v, "\n", "")
        LangTab[v] = k
    end
end
_setLangTab()

-- switch content to lang table key.
local function _text2LangKey(str)
    if not str then
        print("not text in function _fmtText")
        return
    end

    -- \n in LayaAir editor
    str = string.gsub(str, "\\n", "")
    local text = LangTab[str]
    return text and strFmt_("getLang(\"%s\")", text) or [[""]]
end

local uiStruct = require("uiStruct")
local function formatElement(tab)
    if tab.compId ~= 1 then
        print('invalid ui data. first compId must be 1.')
        return
    end

    tab.props.var = tab.props.var or "node_"
    tab.props.x, tab.props.y = 0, 0  -- set xy in code.


    local rstArr, rstTab = {}, {}
    local function format_(v)
        for k, prop in pairs(v.props or {}) do
            v[k] = prop
        end
        v.x = v.props and v.props.x or 0 
        v.y = v.props and v.props.y or 0 

        if v.var then
            if v.innerHTML or v.text then
                v.text = _text2LangKey(v.innerHTML or v.text)   
            end

            v.parent = rstTab[v.nodeParent]
            local struct = uiStruct.createStruct(v)
            if struct then
                table.insert(rstArr, struct)
                rstTab[v.compId] = struct
            end
        else
            print(v.label, "no named [var] in LayaAir" .. (v.type or ""))
        end

        if (v.child) then
            for _, chd in ipairs(v.child) do
                format_(chd)
            end
        end
    end

    format_(tab)
    return rstArr
end

-- 得到lua代码的字符串
local generator = require("generator")
function ui2CodeStr(uiUrl)
    local str = kit.readFile2Str(uiUrl)

    local elements = json.decode(str)
    elements = formatElement(elements)

    local names, codes, strCode = {}, {} -- "\t"
    for _, v in ipairs(elements) do
        assert(v.uitype, (v.name or v.var or v.type) .. "no uitype in node")

        strCode = generator.genCode(v)
        if strCode then
            table.insert(names, v.name)
            table.insert(codes, strCode)
        end
    end

    return generator.genFianlCode(names, codes)
end

function replaceCodeUI(codeUrl, uiUrl)
    print("start replace:", codeUrl, uiUrl)
    if kit.file_exists(codeUrl) then
        local codeStr = ui2CodeStr(uiUrl)
        assert(codeStr, "not get code string")

        local rawCodeStr = kit.readFile2Str(codeUrl)
        codeStr = strFmt_("function %%1:autoUI(root, x, y)\n%s\nend", codeStr)
        codeStr = string.gsub(rawCodeStr, "function[%s]+([^%s]+):autoUI(.-)end", codeStr)
        
        -- assert(codeStr, "raw lua file no exist function [autoUI], can't replace it.")
        kit.writeStr2File(codeUrl, codeStr)
    else
        print("invalid codeUrl:", codeUrl)
    end
end

local function copy2Remote()
    local remote = SrcDir .. "able\\module\\cheatModule\\TestSomethingModule.lua"
    os.execute(string.format("copy TestSomethingModule.lua %s /y", remote))
    print("xcopy done .................. ")
end

local function runTest()
    local runTest = false
    if runTest then
        print("test start...................")
        os.execute("chcp 65001")
        os.execute("cls")

        local modStr = require("modTemplateStr");
        -- xpcall(function ()
        --     os.execute("del TestSomethingModule")
        -- end)

        -- local uiStr = json.decode(jstr)
        -- local insert = kit.readFile2Str(file)

        modStr = strFmt_(modStr, ui2CodeStr())
        kit.writeStr2File("TestSomethingModule.lua", modStr)

        copy2Remote()
        print("test done ................. ")
    end

    return runTest
end

local function getCodeUrl(dirPart, fileName)
    fileName = string.gsub(fileName, ".%w+$", ".lua")

    local tab = {dirPart, fileName}
    -- Module/Panel/other
    local subffix = string.match(fileName, "(%u%l+)%.lua$")
    local part = "view"
    if subffix == "Panel" then
        part = "panel"
    elseif subffix == "Module" then
        part = nil
    end

    if part then
        table.insert(tab, 2, part)
    end

    return table.concat(tab, "/")
end

function exportOne(dirName, fileName)
    local tab = {PathCfg.uiProj.pages, dirName, string.gsub(fileName, ".%w*$", ".ui")}
    local uiUrl = table.concat(tab, "/")

    if kit.file_exists(uiUrl) then
        local dirPart = PathCfg.codePorj.module .. dirName
        local codeUrl = getCodeUrl(dirPart, fileName)
        replaceCodeUI(codeUrl, uiUrl)
    else
        print("failed to out code str, no exist uiUrl:", uiUrl)
    end
end

function exportAll()
    local uiPrefix = "^" .. PathCfg.uiProj.pages
    local uiSuffix = ".ui$"
    kit.handFileInDir(PathCfg.uiProj.pages, function(uiUrl, file)
        local dirPart = string.gsub(uiUrl, uiPrefix, PathCfg.codePorj.module)
        dirPart = string.gsub(dirPart, "/" .. file, "")

        local codeUrl = getCodeUrl(dirPart, file)
        replaceCodeUI(codeUrl, uiUrl)
    end)
end

function run(dirName, fileName)
    if runTest() then
        return
    end

    -- 导出单个文件
    if dirName and fileName then
        exportOne(dirName, fileName)
        return
    end

    print("export all ui ......")
    exportAll()
end


