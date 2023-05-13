-- require("socket")
-- require("LuaPanda").start("127.0.0.1", 8818);
print("arrived file: main.lua")
-- collectgarbage("collect")
-- collectgarbage("stop")


package.path = "src/?.lua;libs/?;" --.. package.path;



require("kit");
local PathCfg = require("PathCfg")

local args = ... or {};
local dirName, fileName = args[1], args[2];

if dirName then
    print("dirName =======>", dirName)
end

if fileName then
    print("fileName =======>", fileName)
end


local prcs = require("process");
prcs.run(dirName, fileName);

print("process all done!")

os.execute("pause");


-- local filePrefix = "^" .. PathCfg.uiProj.pages
-- local fileSuffix = ".ui$"
-- kit.handFileInDir(PathCfg.uiProj.pages, function(url, file)
--     url = string.gsub(url, filePrefix, "F:/aaa")
--     url = string.gsub(url, fileSuffix, ".lua")
--     print(url)
-- end)




-- local str = "function Class:autoUI()\
-- \
-- end"

-- -- print("str:", str)

-- local rst = string.gsub(str, ":autoUI(.*)end", ":autoUI\nhahahhha\nend")
-- print("rst")
-- print(rst)




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

