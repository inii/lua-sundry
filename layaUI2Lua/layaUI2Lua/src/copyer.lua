local copyer = {}

local lfs = require("lfs")
local json = require("json")
local PathCfg = require("PathCfg")
local kit = require("kit")


local function _getCopyMap(path, target)
    local from, to, attr
    local retMap = {}

    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            from = path .. '/' .. file
            to = target .. '/' .. file
            attr = lfs.attributes(from)
            if attr.mode == "directory" then
                -- 没有文件加新建
                if not kit.getFileMode(to) then
                    lfs.mkdir(to, "p")
                end
                    
                _getCopyMap(from, to)
            elseif attr.mode == "file" then
                retMap[from] = to
            end
        end
    end

    return retMap
end

local function _getDeleUrlArr(path, target)
    local toAttr, fromAttr, from, to
    local deleUrls = {}
    -- 删除没用的
    for file in lfs.dir(target) do
        if file ~= "." and file ~= ".." then
            from = path .. '/' .. file
            to = target .. '/' .. file
            toAttr = lfs.attributes(to)
            fromAttr = lfs.attributes(from)
            if toAttr.mode == "directory" then
                if not fromAttr or fromAttr.mode ~= "directory" and fromAttr.nlink ~= 2 then
                    table.insert(deleUrls, to)
                else
                    _getDeleUrlArr(from, to)
                end
            elseif toAttr.mode == "file" and not fromAttr then
                table.insert(deleUrls, to)
            end
        end
    end

    return deleUrls
end

--@path  GameRes下  @targetDir Game/res下
function copyer:copyAtalsTypeRes(path, target)
    local url, attr, toBuffer, fromBuffer
    local sumhexa = kit.sumhexa
    local retMap = _getCopyMap(path, target)

    for from, to in pairs(retMap) do
        fromBuffer = kit.readFile(from, 'rb')
        toBuffer = kit.readFile(to, 'rb')
        -- 图片有更新
        if not toBuffer or sumhexa(toBuffer) ~= sumhexa(fromBuffer) then
            kit.log2file("coped to file: %s", from)
            kit.write2File(to, fromBuffer, 'wb')
        end
    end

    -- 删除无效  -- 暂时不删，
    -- local deleArr = _getDeleUrlArr(path, target)
    -- for i = #deleArr, 1, -1 do
    --     url = deleArr[i]
    --     attr = lfs.attributes(url)
    --     if attr then
    --         if attr.mode == "file" then
    --             kit.log2file("remove file: %s", url)
    --             os.remove (url)
    --         elseif attr.mode == "directory" then
    --             kit.log2file("remove directory: %s", url)
    --             lfs.rmdir(url)
    --         end 
    --     end
    -- end
end

local GameRes = PathCfg.GameRes 
local CodeRes = PathCfg.codeProj.res 
function copyer:copyAtalsTypeResAll()
    local arr = {
        {from= GameRes .. "/ui",
         to= CodeRes .. "/ui"},
    }
    
    for _, v in ipairs(arr) do
        self:copyAtalsTypeRes(v.from, v.to)
    end
end

-- lua模板字符串
function copyer:getLuaTemplateStr(codePath, uiPath)
    local tempUrl
    if string.find(uiPath, "Module.ui$") then
        tempUrl = lfs.currentdir() .. "/template/ModuleTemplate.lua"
    elseif string.find(uiPath, "Panel.ui$") then
        tempUrl = lfs.currentdir() .. "/template/PanelTemplate.lua"
    else
        tempUrl = lfs.currentdir() .. "/template/ViewTemplate.lua"
    end

    local rawCodeStr = kit.readFile(codePath)
    if not rawCodeStr then
        local dir, fileName = string.match(codePath, "(.+)/[^/]*%.%w+$")
        lfs.mkdir(dir, "p")

        rawCodeStr = kit.readFile(tempUrl)
        rawCodeStr = string.gsub(rawCodeStr, "Replace_Name", fileName)
    end

    return rawCodeStr
end







return copyer