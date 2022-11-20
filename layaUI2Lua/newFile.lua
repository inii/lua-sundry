

local dirName, fileName = ...
   
-- local args  = unpack(... or {})     
print("dirName, fileName:", dirName, fileName)

if not dirName then
    print("failed. not input dirName")
    return
end

if not fileName then
    print("failed. not input fileName")
    return
end

local PathCfg = require("config_path")
local kit = require("kit")
local lfs = require("lfs")


-- 复制lua模板
function copyLuaTemplate()
    local targetDir = PathCfg.codePorj.module .. "/" .. dirName
    if not kit.is_dir(targetDir) then -- 已经存在
        local ok, err = lfs.mkdir(targetDir)
        if not ok then return print("failded copyLuaTemplate", err) end
    end
    
    local targetFile, fileStr, tempUrl
    if string.find(dirName, "Module$") then 
        tempUrl = lfs.currentdir() .. "/template/ModuleTemplate.lua"
        targetFile = targetDir .. string.format("/%s.lua", fileName)
    elseif string.find(dirName, "Panel$") then
        tempUrl = lfs.currentdir() .. "/template/PanelTemplate.lua"
        targetFile = targetDir .. string.format("/panel/%s.lua", fileName)
    else
        tempUrl = lfs.currentdir() .. "/template/PanelTemplate.lua"
        targetFile = targetDir .. string.format("/panel/%s.lua", fileName)
    end

    fileStr = kit.readFile2Str(tempUrl)
    fileStr = string.gsub(fileStr, "Replace_Name", fileName)
    kit.writeStr2File(targetFile, fileStr)
end

-- 复制ui模板
function copyUITemplate()
    local targetDir = PathCfg.uiProj.pages .. "/" .. dirName
    if not kit.is_dir(targetDir) then -- 已经存在
        local ok, err = lfs.mkdir(targetDir)
        if not ok then return print("failded copyUITemplate", err) end
    end
    
    local targetFile, fileStr, tempUrl

    tempUrl = lfs.currentdir() .. "/template/UITemplate.ui"
    targetFile = targetDir .. string.format("/%s.ui", fileName)
    fileStr = kit.readFile2Str(tempUrl)
    fileStr = string.gsub(fileStr, "Replace_Name", fileName)
    kit.writeStr2File(targetFile, fileStr)
end

-- 同步图片
function copyRes()
    local fromDir = PathCfg.codePorj.res;
    local toDir = PathCfg.uiProj.res;

    -- 删除旧的
    -- kit.excute("rd /s/q", pathCfg.uiProj.res)

    kit.excute("xcopy /s/y", fromDir, toDir .. "/")
end