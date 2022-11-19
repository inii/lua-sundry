-- require("kit")
-- local lfs = require("lfs") 
-- local attr=lfs.attributes("F://branches//v20220913//src//Client//Game//res//image//common2//bg_alert.png")

-- dump(attr, "attr:")

-- local md5 = require("md5")
-- local str = "#f6db86首 充 送 #1cc1f7非 卖 蓝 色 航 母\n              #f6db86充 值 金 币 双 倍 返 利"
-- print(md5.sumhexa(str))
-- print(md5.sumhexa(str))


local str = "#f6db86首 充 送 #1cc1f7非 卖 蓝 色 航 母\n              #f6db86充 值 金 币 双 倍 返 利" 

str = string.gsub(str, "\n", "")
print(str)

