-- require("socket")
-- require("LuaPanda").start("127.0.0.1", 8818);
print("arrived main.lua")
collectgarbage("stop")

_G.kit = require("kit");
_G.br = "\n\t";

local args = ... or {};
local dirName, fileName = args[1], args[2];
local prcs = require("process");
prcs.run(dirName, fileName);

-- local str = "Act1000SignInPanel.lua"
-- print("is find panel:", string.find(str, "Panel.lua$"))

-- local test, other = require("test")

-- test.hello(test);
-- -- print("test.a",test.a)
-- local other = require("other")
-- other.bye()

-- package.cpath = package.cpath .. ";D://toji//lua-sundry//layaUI2Lua//lib//?.dll"
-- print("package.cpath:", package.cpath)
-- print("package.path:", package.path)
-- local function loopTap(tab, deepth)
--     local curDeep = 1

--     local function _loop(tab, deepth)
--         if curDeep > deepth then
--             return
--         end

--         for key, value in pairs(tab) do
--             if type(value) == "table" then
--                 _loop(value, deepth)
--                 print("this is table", key)
--             else
--                 print(key, value)
--             end
--         end        

--         curDeep = curDeep + 1 
--     end

--     _loop(tab, deepth)
-- end

-- loopTap(package, 4)

