-- 配置代码主目录 和 laya资源目录(uiProj)
-- local codeUrl = "D:/taiFeng_TOD_trunk/wdsm_trunk/src/Client/Game"

local lfs = require("lfs")

local CurDir = lfs.currentdir()
local GameDir = CurDir .. "/../Game"

-- 下面的无需修改
local PathCfg = {
    codeProj = {
        res = GameDir .. "/res", -- 资源路径
        module = GameDir .. "/src/able/module" -- 业务代码模块
    },
    uiProj = {
        res = CurDir .. "/../Game/res",
        pages = CurDir .. "/laya/pages"
    },
    GameRes = CurDir .. "/../GameRes"
}

return PathCfg