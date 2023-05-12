

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

package.path = "src/?.lua;" --.. package.path;
local PathCfg = require("PathCfg")

require("kit")
local lfs = require("lfs")


-- 复制lua模板
function copyLuaTemplate()
    local targetDir = PathCfg.codeProj.module .. "/" .. dirName
    
    local tempUrl
    if string.find(fileName, "Module$") then 
        tempUrl = lfs.currentdir() .. "/template/ModuleTemplate.lua"
    elseif string.find(fileName, "Panel$") then
        tempUrl = lfs.currentdir() .. "/template/PanelTemplate.lua"
        targetDir = targetDir .. "/panel"
    else
        tempUrl = lfs.currentdir() .. "/template/ViewTemplate.lua"
        targetDir = targetDir .. "/view"
    end
    
    if not kit.isDir(targetDir) then -- 不存在，创建
        local ok, err = lfs.mkdir(targetDir)
        if not ok then return print("failded copyLuaTemplate", targetDir, err) end
    end

    local targetFile = targetDir .. string.format("/%s.lua", fileName)
    if kit.isFile(targetFile) then
        print("no need to create a lua file existed.", targetFile)        
        return
    end

    local fileStr = kit.readFile2Str(tempUrl)
    fileStr = string.gsub(fileStr, "Replace_Name", fileName)
    kit.writeStr2File(targetFile, fileStr)
end

-- 复制ui模板
function copyUITemplate()
    local targetDir = PathCfg.uiProj.pages .. "/" .. dirName
    if not kit.isDir(targetDir) then -- 不存在，创建
        local ok, err = lfs.mkdir(targetDir)
        if not ok then return print("failded copyUITemplate", err) end
    end
    
    local targetFile = targetDir .. string.format("/%s.ui", fileName)
    if kit.isFile(targetFile) then
        print("no need to create a ui file existed.", targetFile)        
        return
    end

    local tempUrl = lfs.currentdir() .. "/template/UITemplate.ui"
    local fileStr = kit.readFile2Str(tempUrl)
    kit.writeStr2File(targetFile, fileStr)
end

-- 同步图片
function copyRes()
    local fromDir = PathCfg.codeProj.res;
    local toDir = PathCfg.uiProj.res;

    -- 删除旧的
    -- kit.excute("rd /s/q", pathCfg.uiProj.res)

    kit.excute("xcopy /s/y", fromDir, toDir .. "/")
end



-- copyLuaTemplate()
-- copyUITemplate()
copyRes()

--[[


    -- "F:\trunk\src\Client\Game\res\image"
    -- Client\Game\res
    form: resClient
    
    目标：
    LayaAir 图片目录 layaUI2Lua\LayaUIPro\laya\assets
    其中ui文件夹与Client的图集对应
    -- assets下, 保存一份资源对比； 保存一份 lang 的对比
    

]]

-- diff?   compare md5
