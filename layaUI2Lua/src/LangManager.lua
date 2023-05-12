
 local LangManager = {}

-- lang 所在目录
local PathCfg = require("PathCfg")
local ResDir = PathCfg.codeProj.res


-- 加载cocos游戏工程的目录
local gameLangMap = {}
local function _loadGameLang()
    local url = ResDir .. "/config/common/languageconfig.lua"
    local lang = dofile(url)

    for k, v in pairs(lang or {}) do
        v = string.gsub(v, "\n", "")
        gameLangMap[v] = k
    end
end
_loadGameLang()


-- ui缓存的lang
local LangCachePath = "languageCache.lua"

-- 依次取： 缓存的lang >> cocos工程中的lang
local langCacheMap 
local function _loadCachedLang()
    if io.open(LangCachePath) then
        langCacheMap = dofile(LangCachePath) or {}
        print("exist lang cache file. ")
    else 
        langCacheMap = {}
        print("not lang cache file.")
    end
end
_loadCachedLang()


function LangManager:getGameLangKey(value)
    local key = langCacheMap[value]
    if key then
        return key
    end

    key = gameLangMap[value]
    if key then
        langCacheMap[value] = key
        return key
    end
end

function LangManager:saveLangCache() 
    local file = io.open(LangCachePath, 'w+') 
    if file then
        local str = "return {\n"
        for k, v in pairs(langCacheMap) do
            str = str .. string.format("[\"%s\"] = \"%s\",\n", k, v) 
        end
        str = str .. "}"
        
        file:write(str)
        file:flush()
        file:close()
    end
end
    

return LangManager
