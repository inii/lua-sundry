--[[
    Q:
    1. ?

    todo:
    1. fit screen.
    2. better template.
]] module(..., package.seeall)

local string = string
local strFmt_ = string.format
local nt, nt2, n2t = "\n\t", "\n\t\t", "\n\n\t";

local function _setParentNm(parent)
    return parent and parent.name or "root"
end

function gen_node(dt)
    local x, y = dt.x or 0, dt.y or 0
    if not dt.parent then
        x, y = "x or 0", "y or 0"
    end 

    local w, h = dt.width or 0, dt.height or 0
    local p = _setParentNm(dt.parent)

    local result = {strFmt_("local %s = display.newNode()", dt.name)}
    table.insert(result, strFmt_(":addTo(%s)", p))
    table.insert(result, strFmt_(":pos(%s, %s)", x, y))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":setContentSize(%s, %s)", w, h))

    return table.concat(result, nt)
end

function gen_img(dt)
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
    if ax ~= 0.5 or ay ~= 0.5 then
        table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", ax, ay))
    end

    return table.concat(result, nt)
end

function gen_btn(dt)
    local argTab = {strFmt_("local %s = display.newUIPushButton({", dt.name)}

    if dt.skin then
        table.insert(argTab, "skins = " .. "\"" .. dt.skin .. "\",")
    end
    
    table.insert(argTab, strFmt_("handler = handler(self, self.onBtn%s),", string.sub(dt.name, 4)))

    local w, h = dt.width, dt.height
    if w and h and w > 0 and h > 0 then
        table.insert(argTab, strFmt_("btnSize = {%s, %s},", w, h))
    end

    local x, y = dt.x, dt.y
    table.insert(argTab, strFmt_("x = %s, y = %s,", x, y))
    table.insert(argTab, strFmt_("parent = %s,", _setParentNm(dt.parent)))

    return table.concat(argTab, "\n\t\t") .. "\n\t})"
end

function gen_lab(dt)
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

    return table.concat(result, nt)
end

function gen_rich(dt)
    local result = {strFmt_("local %s = cc.ui.UIRichText.new()", dt.name)}

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))

    local ags = { left = 1, center = 1, right = 1 }
    if ags[dt.align] then
        table.insert(result, strFmt_(":setAlignment(\"%s\")", dt.align))
    end

    local w, h = dt.width, dt.height
    if w > 0 then
        table.insert(result, strFmt_(":setContentSize(%s, %s)", w, h))
        table.insert(result, strFmt_(":ignoreContentAdaptWidth(false)"))
    end

    -- table.insert(result, strFmt_(":setVirticalSpace(1)"))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":pos(%s, %s)", dt.x, dt.y))

    local str = dt.text or "\"\""
    if str and str ~= [[""]] then
        table.insert(result, strFmt_(":setString(%s, %s)", str, dt.fontSize))
    end

    return table.concat(result, nt)
end

function gen_lsv(dt)
    local ax, ay = dt.ax, dt.ay
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    local str0
    if dt.itemName and dt.moduleName then
        str0 = strFmt_([[-- local %s = ab.import(".%s.view.%s", "able.module")]], dt.itemName, dt.moduleName,
            dt.itemName)
    end

    -- 坐标转化为锚点(0，0)
    x, y = x - ax * w, y - ay * h
    local paramArr = {strFmt_("local %s = cc.ui.UIListView.new({", dt.name)}
    local dirStr
    if dt.scrollX and dt.scrollY then
        dirStr = "cc.ui.UIScrollView.DIRECTION_BOTH"
    elseif dt.scrollY then
        dirStr = "cc.ui.UIScrollView.DIRECTION_VERTICAL"
    else
        dirStr = "cc.ui.UIScrollView.DIRECTION_HORIZONTAL"
    end

    table.insert(paramArr, strFmt_("direction = %s,", dirStr))
    table.insert(paramArr, strFmt_("viewRect = cc.rect(%s, %s, %s, %s),", x, y, w, h))
    
    table.insert(paramArr, "async = true,")
    table.insert(paramArr, "-- bgColor = cc.c4b(255,110,330,155),")

    local str1 = table.concat(paramArr, nt2) .. "\n\t})"
    local str2 = strFmt_(":addTo(%s)", _setParentNm(dt.parent))
    local str3 = strFmt_([[%s:setDelegate(handler(self, self.%sDelegate))]], dt.name, dt.name)

    local arr = str0 and {str0, str1, str2, str3} or {str1, str2, str3}
    return table.concat(arr, nt)
end

function gen_lsv2(dt)
    -- assert(ax == 0 and ay == 0, strFmt_("listview anchron must be (0, 0), but ax = %s, ay=%s.", ax, ay))

    local ax, ay = dt.ax, dt.ay
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    -- 坐标转化为锚点(0，0)
    x, y = x - ax * w, y - ay * h

    local headStr = ""
    if dt.itemName and dt.moduleName then
        headStr = strFmt_([[local %s = ab.import(".%s.view.%s", "able.module")]], dt.itemName, dt.moduleName,
            dt.itemName)
    end

    local midArr = {}
    table.insert(midArr, "local listParams = {")
    table.insert(midArr, strFmt_("parent = %s,", _setParentNm(dt.parent)))
    table.insert(midArr, strFmt_("viewRect = cc.rect(%s, %s, %s, %s),", x, y, w, h))
    table.insert(midArr, strFmt_("isDebug = %s,", "true"))

    if dt.itemName then
        table.insert(midArr, strFmt_("cellClass = %s,", dt.itemName))
    end

    if dt.itemH then
        table.insert(midArr, strFmt_("itemSize = cc.size(%s, %s),", w, dt.itemH))
    end

    table.insert(midArr, "}")
    local midStr = table.concat(midArr, nt2)

    local tailArr = {}
    table.insert(tailArr, strFmt_("local listview = UIUtil:createListview(%s, %s)", "{len=3}", "listParams"))
    table.insert(tailArr, "listview:reload()")
    local tailStr = table.concat(tailArr, "\n\t")

    return table.concat({headStr, midStr, tailStr}, "\n\t")
end

function gen_scv(dt)
    local ax, ay = dt.ax, dt.ay
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    -- 坐标转化为锚点(0，0)
    x, y = x - ax * w, y - ay * h

    -- local str0 = strFmt_("local %sC = display.newNode()", dt.name)

    local arr2 = {}
    table.insert(arr2, strFmt_("local %s = cc.ui.UIScrollView.new({", dt.name))

    local dirStr
    if dt.scrollX and dt.scrollY then
        dirStr = "cc.ui.UIScrollView.DIRECTION_BOTH"
    elseif dt.scrollY then
        dirStr = "cc.ui.UIScrollView.DIRECTION_VERTICAL"
    else
        dirStr = "cc.ui.UIScrollView.DIRECTION_HORIZONTAL"
    end
    table.insert(arr2, strFmt_("direction = %s,", dirStr))

    table.insert(arr2, strFmt_("viewRect = cc.rect(%s, %s, %s, %s),", x, y, w, h))
    table.insert(arr2, "-- bgColor = cc.c4b(88, 155, 90, 155)")
    local str1 = table.concat(arr2, nt2) .. "\n\t})"

    local str2 = strFmt_(":addTo(%s)", _setParentNm(dt.parent))
    local str3 = strFmt_([[:addScrollNode(display.newNode())]], dt.name)

    return table.concat({str1, str2, str3}, nt)
end

function genCode(v)
    local genCodeFun = generator["gen_" .. v.uitype]
    if not genCodeFun then
        print(v.name, "invalid uitype: ", v.uitype)
        return ""
    end

    return genCodeFun(v)
end

function genFianlCode(names, codes)
    local str = "\t" .. table.concat(codes, n2t)

    local nmStr = {}
    for i, nm in ipairs(names) do
        if not string.find(nm, "N$") then
            table.insert(nmStr, strFmt_("%s=%s", nm, nm))
        end
    end
    str = str .. "\n\n\treturn {" .. table.concat(nmStr, ", ") .. "}"
    return str
end
