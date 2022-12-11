--[[
    Q:
    1. why list not need position?

    todo:
    1. finish scrollview.
    2. better template.

]] 
module(..., package.seeall)

local strFmt_ = string.format
local br = "\n\t";

local function _setParentNm(parent)
    return parent and parent.name or "root"
end

function generator.gen_node(dt)
    local x, y = dt.x or 0, dt.y or 0
    local w, h = dt.width or 0, dt.height or 0
    local p = _setParentNm(dt.parent)

    local result = {strFmt_("local %s = display.newNode()", dt.name)}
    table.insert(result, strFmt_(":addTo(%s)", p))
    table.insert(result, strFmt_(":pos(%s, %s)", x, y))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":setContentSize(%s, %s)", w, h))

    return table.concat(result, "\n\t")
end

function generator.gen_img(dt)
    local result = {}

    local url = "\"" .. dt.skin .. "\""
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    local constructArr = {url, x, y}
    local isSca9
    if dt.sizeScale9 then
        -- 上右下左
        local raw = kit.parse2Num(dt.sizeScale9)
        table.insert(constructArr, strFmt_("cc.size(%s, %s)", w, h))
        table.insert(constructArr, strFmt_("cc.rect(%s, %s, %s, %s)", raw[4], raw[3], 1, 1))

        table.insert(result,
            strFmt_("local %s = display.newScale9Sprite(%s)", dt.name, table.concat(constructArr, ", ")))
    else
        table.insert(result, strFmt_("local %s = display.newSprite(%s)", dt.name, table.concat(constructArr, ", ")))
    end

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))
    local line
    if dt.scaleX and dt.scaleY and dt.scaleX == dt.scaleY then
        line = strFmt_(":setScale(%s)", dt.scaleX)
        table.insert(result, line)
    else
        if dt.scaleX then
            line = strFmt_(":setScaleX(%s)", dt.scaleX)
            table.insert(result, line)
        end

        if dt.scaleY then
            line = strFmt_(":setScaleY(%s)", dt.scaleY)
            table.insert(result, line)
        end
    end

    local ax, ay = dt.ax, dt.ay
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", ax, ay))

    return table.concat(result, br)
end

function generator.gen_btn(dt)
    local headStr = strFmt_("local %s = display.newUIPushButton({", dt.name)
    local tailStr = "})"

    local spaces = "\n\t\t\t\t\t\t"
    local argTab = {}
    if dt.skin then
        table.insert(argTab, "skins = " .. "\"" .. dt.skin .. "\",")
    end

    table.insert(argTab, "handler = handler(self, self.closeClick),")

    local w, h = dt.width, dt.height
    if w and h and w > 0 and h > 0 then
        table.insert(argTab, strFmt_("btnSize = {%s, %s},", w, h))
    end

    local x, y = dt.x, dt.y
    table.insert(argTab, strFmt_("x = %s, y = %s,", x, y))
    table.insert(argTab, strFmt_("parent = %s,", _setParentNm(dt.parent)))

    local midStr = table.concat(argTab, spaces)
    return headStr .. midStr .. tailStr
end

function generator.gen_lab(dt)
    local result = {}

    local str = dt.text or "\"\""
    -- local spaces = "\n\t\t\t\t\t\t"
    local argTab = {strFmt_("local %s = display.newTTFLabel({text = %s", dt.name, str)}

    if dt.fontSize then
        table.insert(argTab, strFmt_("size = %s", dt.fontSize))
    end

    if dt.font == "SimHei" then
        table.insert(argTab, "font = display.FONT_THICK")
    end

    if dt.color then
        table.insert(result, strFmt_("local color = GameUtil:parseColor3b(\"%s\")", dt.color))

        table.insert(argTab, "color = color")
    end

    table.insert(result, table.concat(argTab, ", ") .. "})")

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":pos(%s, %s)", dt.x, dt.y))

    return table.concat(result, "\n\t")
end

function generator.gen_rich(dt)
    local result = {strFmt_("local %s = cc.ui.UIRichText.new()", dt.name)}

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))

    local w, h = dt.width, dt.height
    table.insert(result, strFmt_(":setContentSize(%s, %s)", w, h))
    table.insert(result, strFmt_(":ignoreContentAdaptWidth(false)"))
    table.insert(result, strFmt_(":setVirticalSpace(1)"))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":pos(%s, %s)", dt.x, dt.y))

    local str = dt.text or "\"\""
    if str and str ~= [[""]] then
        table.insert(result, strFmt_(":setString(%s, %s)", str, 18))
    end

    return table.concat(result, "\n\t")
end

function generator.gen_lsv(dt)
    -- assert(ax == 0 and ay == 0, strFmt_("listview anchron must be (0, 0), but ax = %s, ay=%s.", ax, ay))

    local ax, ay = dt.ax, dt.ay
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    -- 坐标转化为锚点(0，0)
    x, y = x - ax * w, y - ay * h

    local pstrArr = {}
    if dt.itemName then
        -- strFmt_([[local %s = ab.import(".activityModule.view.%s", "able.module")]], dt.itemName, dt.itemName)
        strFmt_([[local %s = ab.import(".autoTestModule.view.%s", "able.module")]], dt.itemName, dt.itemName)
    end

    table.insert(pstrArr, "local listParams = {")
    table.insert(pstrArr, strFmt_("\tparent = %s,", _setParentNm(dt.parent)))
    table.insert(pstrArr, strFmt_("\tviewRect = cc.rect(%s, %s, %s, %s),", x, y, w, h))
    table.insert(pstrArr, strFmt_("\tisDebug = %s,", "true"))

    if dt.itemName then
        table.insert(pstrArr, strFmt_("\tcellClass = %s,", dt.itemName))
    end

    if dt.itemH then
        table.insert(pstrArr, strFmt_("\titemSize = cc.size(%s, %s),", w, dt.itemH))
    end

    table.insert(pstrArr, "}\n")

    table.insert(pstrArr, strFmt_("local listview = UIUtil:createListview(%s, %s)", "{len=3}", "listParams"))
    table.insert(pstrArr, "listview:reload()")

    return table.concat(pstrArr, br)
end

-- 选
-- local function generator.gen_menu()
--     return ""
-- end 


function generator.genCode(v, result)
    local genCodeFun = generator["gen_" .. v.uitype]
    if not genCodeFun then
        print(v.name , "invalid uitype: ", v.uitype)
        return ''
    end

    result = result .. (genCodeFun(v))
    result = result .. "\n" .. br
    return result
end

