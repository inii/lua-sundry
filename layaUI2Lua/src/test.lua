-- require("kit")
-- local lfs = require("lfs") 
-- local attr=lfs.attributes("F://branches//v20220913//src//Client//Game//res//image//common2//bg_alert.png")

-- dump(attr, "attr:")

-- local md5 = require("md5")
-- local str = "#f6db86首 充 送 #1cc1f7非 卖 蓝 色 航 母\n              #f6db86充 值 金 币 双 倍 返 利"
-- print(md5.sumhexa(str))
-- print(md5.sumhexa(str))


print("in test file:", ...)


local md5 = require("md5")

local str = "sal;ja;sldgjsglfd"
print(md5.sumhexa(str))
local str2 = "sal;ja;sldgjsglfd"

print(md5.sumhexa(str2))



-- local str = "#f6db86首 充 送 #1cc1f7非 卖 蓝 色 航 母\n              #f6db86充 值 金 币 双 倍 返 利" 

-- str = string.gsub(str, "\n", "")
-- print(str)


-- module(..., package.seeall)

-- print("hhexxxxxxxx")
-- a = 1
-- function hello(self)
--     print("in function hello", a)
-- end

-- local print= print
-- module("other")

-- function bye()
--     print("bye 再见 ")
-- end

-- local kit = require("kit")
-- local PathCfg = require("config_path")
-- local dirName = ""
-- local targetDir = PathCfg.codePorj.module --.. "/" .. dirName


-- print("is dir:", kit.isDir(targetDir))

-- local str = "function AutoTestModule:initUI() self:autoUI()  end \n   function AutoTestModule:autoUI() xxx end"
-- -- "hahha"
-- local rst = string.gsub(str, "([^self]:autoUI .* end)", "hahahhhahah")

-- print("result:", rst)


-- local rst = string.gsub(str, "auto(.*)end", "hahah")
-- print(rst)

-- for k, v in string.gmatch(str, "auto(.*)end", -1) do
--     print(k, v)
-- end

-- print(string.gsub(" function AutoTestModule:ctor() self:autoUI()| function xxx:autoUI() xxx end", "function[%s]+([^%s]+):autoUI(.*)end",  "%1codeStr%1"))


-- print(string.format(":autoUI()%%1\n%s\nend", "codeStr"))




-- print(string.match("fileName", "%u[^%s]+$"))
-- print(string.match("AutoTestModule.lua", "(%u%l+)%.lua$"))

-- local path = [[ C:\Users\Administrator\Desktop\lua-sundry\layaUI2Lua/AutoTestGiftCell.ui]]
-- print(string.gsub(path, [[\]], [[/]]))

-- local a = {a=3,b=4}

-- local c = setmetatable({}, {__index = a})

-- c.a=5
-- print(c.a) 
-- print(rawget(c, "a"))