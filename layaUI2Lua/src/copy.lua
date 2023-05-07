print(" layaUI2Lua  hello xxxxxxxxx ")



local lfs = require("lfs")
local json = require("json")
local md5 = require("md5")
-- local str = "#f6db86首 充 送 #1cc1f7非 卖 蓝 色 航 母\n              #f6db86充 值 金 币 双 倍 返 利"
-- print(md5.sumhexa(11111))
-- print(md5.sumhexa("11111"))

-- io.read(*)

local path = "D:/toji/lua-sundry/layaUI2Lua/src/1216.png"
-- "D:/toji/lua-sundry/layaUI2Lua/src/xxx.png"

local f = io.open(path)
local lines = f:read("*all")


print(md5.sumhexa(lines))

local path = "D:/toji/lua-sundry/layaUI2Lua/src/xxx.png"
local f = io.open(path)
local lines = f:read("*all")

print("============================")
print(md5.sumhexa(lines))


--[[
    从游戏目录复制到 ui编辑器目录
]]


local test = {key=123, k2=345}
local path = "D:/toji/lua-sundry/layaUI2Lua/src/xxx.json"
local f = io.open(path, "w")
f:write(json.encode(test))
f:flush()
f:close()



local md5Path = "D:/toji/lua-sundry/layaUI2Lua/src/xxx.json"
local function _getPicMD5Tab()
    local f = io.open(md5Path)
    return json.decode(f:read("*all"))
end

local md5Tab = _getPicMD5Tab()


-- 遍历game res 文件夹，如果md5不存在，复制，  如果md5不相同，复制、
-- 


