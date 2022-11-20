local lfs = require("lfs")
-- print("lfs.currentdir():", lfs.currentdir())

-- local md5 = require("md5")
local json = require("json")
local generator = require("generator")

-- 主目录
local MainDir = "F:/trunk/Client/Game"
-- 代码目录
local SrcModuleDir = MainDir .. "/src/able/module"
-- 资源目录
local ResDir = "F:/trunk/Client/Game/res"
-- ui代码输出目录
local uiCodeDir = SrcModuleDir .. "/activityModule"

-- laya ui文件路径
local uiDir = "F:/myLaya/laya/pages"
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

    if(parent and parent.props and parent.props.height) then
        y = parent.props.height - y
    end

    return x, y
end

local function _getWH(dt)
    local w, h = dt.width, dt.height
    local url = dt.skin
    if not url or url == "" then
        print((dt.props and dt.props.var or dt.type), " not url")
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
            uitype = uitype,
        }
    end,
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
        local itemNm = child and child.props and child.props.runtime
        local itemH
        if itemNm then
            itemH = _geCellHeight(itemNm)
        end

        node.itemName = itemNm
        node.itemH = itemH
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

local process = {}
-- --  declare functions
-- local genSprite, genButton, genText, genRichText, genList, genMenu

local function formatElement(tab)
    _G.assert(tab.compId == 1, 'invalid ui data. first comId must be 1.')
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
                kit.log("undefined ui type: " .. (prefix or v.type or ""))
            end
        else
            kit.log("no named [var] in LayaAir" .. (v.type or ""))
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

local function getLuaCodeStr(url)
    local result = "\t"
    print("url:", url)
    local str = kit.readFile2Str(url)
    print("str:", str)

    local elements = json.decode(str)
    elements = formatElement(elements)
    -- dump(elements, "elements: ")
    for k, v in pairs(elements) do
        if not v.uitype then
            dump(elements, "uitype: " .. v.name)
        end

        if not generator["gen_" .. v.uitype] then
            dump(v, "uitype: " .. v.name, v.uitype)
            print("v.var", v.props.var)
            print("v.uitype", v.uitype)
            print("gen_" .. v.uitype)
        end

        result = result .. (generator["gen_" .. v.uitype](v))
        result = result .. "\n" .. br
    end

    return result
end

local function copy2Remote()
    local remote = SrcDir .. "able\\module\\cheatModule\\TestSomethingModule.lua"
    os.execute(string.format("copy TestSomethingModule.lua %s /y", remote))

    local url = "" -- uiCodeDir .. 

    print("xcopy done .................. ")
end

local function test()
    local modStr = require("modTemplateStr");
    -- xpcall(function ()
    --     os.execute("del TestSomethingModule")
    -- end)

    -- local uiStr = json.decode(jstr)
    -- local insert = kit.readFile2Str(file)

    modStr = strFmt_(modStr, getLuaCodeStr())
    kit.writeStr2File("TestSomethingModule.lua", modStr)
end

function process.run()
    if runTest then
        os.execute("chcp 65001")
        os.execute("cls")
        print("process run...................")
        test()
        copy2Remote()
        print("process done ................. ")
        return
    end

    -- 目录下只有一层目录
    local url, attr, target, suffix
    for file in lfs.dir(uiDir) do
        if file ~= "." and file ~= ".." then
            url = uiDir .. '/' .. file
            attr = lfs.attributes(url)
            if attr.mode == "directory" then
                print(url .. "  -->  " .. attr.mode)
                -- kit.handFileInDir(url, handler)
                -- 存在代码模块
                target = SrcModuleDir .. "/" .. file
                if kit.is_dir(target) then
                    for file in lfs.dir(url) do
                        if file ~= "." and file ~= ".." then
                            print("url:", url)
                            -- url = string.gsub(url .. '/' .. file, [[\]], [[/]])
                            suffix = string.gsub(file, ".ui", ".lua")
                            kit.writeStr2File(target .. "/ui/" .. suffix, getLuaCodeStr(url .. "/" .. file))
                        end
                    end
                end
            end
        end
    end


end

return process

