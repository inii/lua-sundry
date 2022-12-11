-- 配置代码主目录 和 ui主目录
local codeUrl = "F:/trunk/src/Client/Game";
local uiUrl = "F:/myLaya/laya"


-- 下面的无需修改
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
        pages = uiUrl .. "/pages"
    }
}
