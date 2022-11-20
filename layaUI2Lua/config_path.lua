-- 文件路径配置
local codeUrl = "F:/trunk/Client/Game";
local uiUrl = "F:/myLaya/laya"

return {
    codePorj = {
        main = codeUrl,
        resName = "res",
        res = codeUrl .. "/res", -- 资源路径
        module = codeUrl .. "/src/able/module" -- 业务代码模块
    },
    uiProj = {
        main = uiUrl,
        resName = "assets",
        res = uiUrl .. "/assets",
        pages = uiUrl .. "pages"
    }
}
