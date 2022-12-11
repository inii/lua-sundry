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
]] module(..., package.seeall)

local lfs = require("lfs")
-- print("lfs.currentdir():", lfs.currentdir())

local dump = kit.dump

-- local md5 = require("md5")
local json = require("json")

-- 主目录
-- local MainDir = "F:/trunk/Client/Game"
-- 代码目录 (lua code directory)
-- local SrcModuleDir = MainDir .. "/src/able/module"

local PathCfg = require("config_path")

-- 资源目录
local ResDir = PathCfg.codePorj.res

-- "F:/trunk/Client/Game/res"
-- ui代码输出目录
-- local uiCodeDir = SrcModuleDir .. "/activityModule"

-- laya ui文件路径
-- local uiDir = "F:/myLaya/laya/pages"
local strFmt_ = string.format

-- 方便获取lang文件的key
local LangTab = {}
local function _switchLang()
    local url = ResDir .. "/config/common/languageconfig.lua"
    local lang = dofile(url)
    -- kit.writeStr2File("lang.txt", "")

    for k, v in pairs(lang) do
        -- 取消换行符
        v = string.gsub(v, "\n", "")
        -- md5.sumhexa(v)
        LangTab[v] = k
    end
end
_switchLang()

-- 将文字转化为lang文件中的key
local function _fmtText(str)
    if not str then
        print("not text in function _fmtText")
        return
    end
    -- print("str:", str)
    -- print("md5", md5.sumhexa(str))
    -- 取消laya编辑器中的换行符
    str = string.gsub(str, "\\n", "")
    local text = LangTab[str]
    return text and strFmt_("getLang(\"%s\")", text) or [[""]]
end

local function _getXY(dt, parent)
    if not dt then
        print("not prop")
    end

    local x, y = dt.x or 0, dt.y or 0
    if x == 0 then
        print(dt.var .. " x no assign")
    end
    if y == 0 then
        print(dt.var .. " y no assign")
    end

    if (parent and parent.height) then
        y = parent.height - y
    end

    return x, y
end

local function _getWH(dt)
    local w, h = dt.width, dt.height
    local url = dt.skin
    if not url or url == "" then
        print((dt.var or dt.type), " not url")
        return w or 0, h or 0
    end

    if not w or not h then
        local rawW, rawH = kit.getImageSize(ResDir .. "/" .. url)
        w = w or rawW
        h = h or rawH
    end

    return w, h
end

local function _geCellHeight(cellName)
    local url = lfs.currentdir() .. "/" .. cellName .. ".ui";
    local tab = json.decode(kit.readFile2Str(url))
    dump(tab, "cell data")

    return tab and tab.props and tab.props.height or 0
end

local NodeStruct = {
    -- @raw 原始ui数据
    new = function(uitype, raw, parent)
        if not raw then
            print("not raw ui data")
            return
        end

        local prop = raw.props
        local x, y = _getXY(prop, parent)
        local w, h = _getWH(prop)

        return {
            x = x,
            y = y,
            ax = prop.anchorX or 0, -- 锚点
            ay = prop.anchorY or 1,
            width = w,
            height = h,
            name = prop.var,
            scaleX = prop.scaleX, -- 缩放(不需要默认值)
            scaleY = prop.scaleY,
            rt = prop.rotation, -- 旋转(不需要默认值)
            parent = parent, -- 父节点
            uitype = uitype
        }
    end
}

local ImgStruct = {
    new = function(uitype, raw, parent)
        local node = NodeStruct.new(uitype, raw, parent)
        local prop = raw.props
        node.skin = prop.skin -- 图片路径
        node.sizeScale9 = prop.sizeGrid -- 九宫格分割

        return node
    end
}

local LabStruct = {
    new = function(uitype, raw, parent)
        local node = NodeStruct.new(uitype, raw, parent)
        if parent.uitype == "btn" then
            node.ax = 0.5
            node.ay = 0.5
            node.x = 0
            node.y = 0
        end

        local prop = raw.props
        node.font = prop.font
        node.fontSize = prop.fontSize or 18
        node.color = prop.color or "#ffffff"
        node.text = _fmtText(prop.innerHTML or prop.text)

        return node
    end
}

local ListStruct = {
    new = function(uitype, raw, parent)
        local node = NodeStruct.new(uitype, raw, parent)
        -- listview listview item 需要的参数
        local child = raw.child and raw.child[1]
        local prop = raw.props

        local itemNm = prop.runtime
        local itemH
        if itemNm then
            itemH = _geCellHeight(itemNm)
        end

        node.itemName = itemNm
        node.itemH = itemH

        return node
    end
}

local UITypes = {
    node = NodeStruct,
    img = ImgStruct,
    btn = ImgStruct,
    lab = LabStruct,
    rich = LabStruct,
    lsv = ListStruct
}

-- --  declare functions
-- local genSprite, genButton, genText, genRichText, genList, genMenu

local function formatElement(tab, uiUrl)
    -- dump(tab)
    if tab.compId ~= 1 then
        print('invalid ui data. first compId must be 1.')
        return
    end

    tab.props.var = tab.props.var or "node_"
    tab.props.x, tab.props.y = 0, 0

    local rst = {}
    local function format_(v)
        local parent = rst[v.nodeParent]
        local prop = v.props
        if prop and prop.var then
            -- prefix : UIType   "btnClick" -> "btn"
            local prefix = UITypes[prop.var] and prop.var or string.match(prop.var, "^(%l+)")

            if prefix and UITypes[prefix] then
                rst[v.compId] = UITypes[prefix].new(prefix, v, parent)
            else
                print(v.name, "undefined ui type: " .. (prefix or v.type or ""))
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
    return rst
end

-- 得到lua代码的字符串
local generator = require("generator")
function ui2CodeStr(uiUrl)
    print("uiUrl:", uiUrl)
    local str = kit.readFile2Str(uiUrl)
    -- print("str:", str)

    local elements = json.decode(str)
    elements = formatElement(elements, uiUrl)
    -- dump(elements, "elements: ")

    local result = "\t"
    local genCodeFun
    for k, v in pairs(elements) do
        if not v.uitype then
            print("no uitype in node", v.name)
        end

        result = generator.genCode(v, result)
    end

    return result
end

function replaceCodeUI(codeUrl, uiUrl)
    print("start replace:", codeUrl, uiUrl)
    if kit.file_exists(codeUrl) then
        local codeStr = ui2CodeStr(uiUrl)
        assert(codeStr, "not get code string")

        local rawCodeStr = kit.readFile2Str(codeUrl)
        codeStr = strFmt_("function %%1:autoUI(root)\n%s\nend", codeStr)
        codeStr = string.gsub(rawCodeStr, "function[%s]+([^%s]+):autoUI(.*)end", codeStr)
        -- print("replace string :", codeStr)

        assert(codeStr, "raw lua file no exist function [autoUI], can't replace it.")
        kit.writeStr2File(codeUrl, codeStr)
    else
        print("invalid codeUrl:", codeUrl)
    end
end

local function copy2Remote()
    local remote = SrcDir .. "able\\module\\cheatModule\\TestSomethingModule.lua"
    os.execute(string.format("copy TestSomethingModule.lua %s /y", remote))

    local url = "" -- uiCodeDir 

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

-- 导出单个ui文件 @fileName 不带文件格式 
function outOneCodestr(dirName, fileName)
    local tab = {PathCfg.uiProj.pages, dirName, fileName .. ".ui"}
    local uiUrl = table.concat(tab, "/")

    if kit.file_exists(uiUrl) then
        local dirPart = PathCfg.codePorj.module .. dirName
        local codeUrl = getCodeUrl(dirPart, fileName)
        replaceCodeUI(codeUrl, uiUrl)
    else
        print("failed to out code str, no exist uiUrl:", uiUrl)
    end
end

-- 导出所有的ui文件
function outAllCodestr()
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
        outOneCodestr(dirName, fileName)
        return
        -- if kit.file_exists(uiUrl) then
        --     local codeStr = ui2CodeStr(uiUrl)
        --     -- kit.writeStr2File(target .. "/ui/" .. suffix, )
        -- end
    end

    print("export all ui ......")
    outAllCodestr()
end

-- 目录下只有一层目录
-- local url, attr, target, suffix
-- for file in lfs.dir(uiDir) do
--     if file ~= "." and file ~= ".." then
--         url = uiDir .. '/' .. file
--         attr = lfs.attributes(url)
--         if attr.mode == "directory" then
--             print(url .. "  -->  " .. attr.mode)
--             -- kit.handFileInDir(url, handler)
--             -- 存在代码模块
--             target = SrcModuleDir .. "/" .. file
--             if kit.isDir(target) then
--                 for file in lfs.dir(url) do
--                     if file ~= "." and file ~= ".." then
--                         print("url:", url)
--                         -- url = string.gsub(url .. '/' .. file, [[\]], [[/]])
--                         suffix = string.gsub(file, ".ui", ".lua")
--                         kit.writeStr2File(target .. "/ui/" .. suffix, ui2CodeStr(url .. "/" .. file))
--                     end
--                 end
--             end
--         end
--     end
-- end
