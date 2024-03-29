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


local function _getScaleStr(dt)
    local line
    if dt.scaleX and dt.scaleY and dt.scaleX == dt.scaleY then
        line = strFmt_(":setScale(%s)", dt.scaleX)
    else
        if dt.scaleX and dt.scaleY then
            line = strFmt_(":setScale(%s, %s)", dt.scaleX, dt.scaleY)
        elseif dt.scaleX then
            line = strFmt_(":setScaleX(%s)", dt.scaleX)
        elseif dt.scaleY then
            line = strFmt_(":setScaleY(%s)", dt.scaleY)
        end
    end

    return line
end

local function _getRotateStr(dt)
    if dt.rotation then
        return strFmt_(":setRotation(%s)", dt.rotation)
    end
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

    local line = _getRotateStr(dt)
    if line then
        table.insert(result, line)
    end
    
    if dt.visible == "false" or dt.visible == false then
        table.insert(result, ":setVisible(false)")
    end

    return table.concat(result, nt)
end

function gen_img(dt)
    local result = {}

    local url = dt.url and "\"" .. dt.url .. "\"" or "nil"
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height
    w = w == 0 and dt.txW or w
    h = h == 0 and dt.txH or h

    local constructArr = {url, x, y}
    local isSca9
    if dt.url and dt.sizeScale9 then
        -- 上右下左
        local raw = kit.parse2Num(dt.sizeScale9)
        table.insert(constructArr, strFmt_("cc.size(%s, %s)", w, h))

        local sw = dt.txW - raw[4] - raw[2]
        local sh = dt.txH - raw[3] - raw[1]
        table.insert(constructArr, strFmt_("cc.rect(%s, %s, %s, %s)", raw[4], raw[3], sw, sh))

        table.insert(result,
            strFmt_("local %s = display.newScale9Sprite(%s)", dt.name, table.concat(constructArr, ", ")))
    else
        table.insert(result, strFmt_("local %s = display.newSprite(%s)", dt.name, table.concat(constructArr, ", ")))
    end

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))
    
    local line = _getScaleStr(dt)
    if line then
        table.insert(result, line)
    end

    if dt.touchable then
        table.insert(result, ":setTouchEnabled(true)")
    end

    line = _getRotateStr(dt)
    if line then
        table.insert(result, line)
    end

    local ax, ay = dt.ax, dt.ay
    if ax ~= 0.5 or ay ~= 0.5 then
        table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", ax, ay))
    end

    if dt.alpha then
        table.insert(result, strFmt_(":setOpacity(%s)", math.floor(dt.alpha*255)))
    end

    if dt.visible == "false" or dt.visible == false then
        table.insert(result, ":setVisible(false)")
    end

    if not dt.sizeScale9 and w ~= 0 and h ~= 0 then
        if (w ~= dt.txW and h ~= dt.txH) then
            table.insert(result, strFmt_("GameUtil:scaleTo(%s, %s, %s)", dt.name, w, h))
        elseif w ~= dt.txW and h == dt.txH then
            table.insert(result, strFmt_("GameUtil:scaleToWidth(%s, %s)", dt.name, w))
        elseif w == dt.txW and h ~= dt.txH then              
            table.insert(result, strFmt_("GameUtil:scaleToHeight(%s, %s)", dt.name, h))
        end
    end

    return table.concat(result, nt)
end

function gen_btn(dt)
    local argTab = {strFmt_("local %s = display.newUIPushButton({", dt.name)}

    if dt.url then
        table.insert(argTab, "skins = " .. "\"" .. dt.url .. "\",")
    end

    local suffix = string.gsub(dt.name, "N$", "") 
    table.insert(argTab, strFmt_("handler = handler(self, self.onBtn%s),", string.sub(suffix, 4)))

    local w, h = dt.width, dt.height
    w = w == 0 and dt.txW or w
    h = h == 0 and dt.txH or h
    if w > 0 and h > 0 then
        table.insert(argTab, strFmt_("btnSize = {%s, %s},", w, h))
    end

    local x, y = dt.x, dt.y
    table.insert(argTab, strFmt_("x = %s, y = %s,", x, y))
    table.insert(argTab, strFmt_("parent = %s,", _setParentNm(dt.parent)))

    local result = table.concat(argTab, "\n\t\t") .. "\n\t})"
    if dt.visible == "false" or dt.visible == false then
        result = result .. "\n\t" .. ":setVisible(false)"
    end

    local line = _getScaleStr(dt)
    if line then
        result = result .. "\n\t" .. line
    end

    line = _getRotateStr(dt)
    if line then
        result = result .. "\n\t" .. line
    end

    return result
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
        table.insert(argTab, "font = display.FONT_BOLD")
    end

    if dt.color then
        table.insert(result, strFmt_("local color = GameUtil:parseColor3b(\"%s\")", dt.color))

        table.insert(argTab, "color = color")
    end
    
    if dt.outlineColor then
        table.insert(result, strFmt_("local outcolor = GameUtil:parseColor3b(\"%s\")", dt.outlineColor))
        -- table.insert(argTab, "outlineColor = outcolor")
    end

    table.insert(result, table.concat(argTab, ", ") .. "})")

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))
    table.insert(result, strFmt_(":setAnchorPoint(%s, %s)", dt.ax, dt.ay))
    table.insert(result, strFmt_(":pos(%s, %s)", dt.x, dt.y))

    local line = _getScaleStr(dt)
    if line then
        table.insert(result, line)
    end

    line = _getRotateStr(dt)
    if line then
        table.insert(result, line)
    end

    if dt.outlineColor then
        table.insert(result, strFmt_(":enableOutline(%s, %s)", "outcolor", dt.outline or 1))
    end

    if dt.visible == "false" or dt.visible == false then
        table.insert(result, ":setVisible(false)")
    end
    return table.concat(result, nt)
end

function gen_rich(dt)
    local result = {strFmt_("local %s = cc.ui.UIRichText.new()", dt.name)}

    local pname = _setParentNm(dt.parent)
    table.insert(result, strFmt_(":addTo(%s)", pname))

    local ags = {
        left = 1,
        center = 1,
        right = 1
    }
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

    if dt.visible == "false" or dt.visible == false then
        table.insert(result, ":setVisible(false)")
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
    elseif dt.scrollX then
        dirStr = "cc.ui.UIScrollView.DIRECTION_HORIZONTAL"
    else
        dirStr = "cc.ui.UIScrollView.DIRECTION_VERTICAL"
    end

    table.insert(paramArr, strFmt_("direction = %s,", dirStr))
    table.insert(paramArr, strFmt_("viewRect = cc.rect(%s, %s, %s, %s),", x, y, w, h))

    table.insert(paramArr, "async = true,")
    table.insert(paramArr, "-- bgColor = cc.c4b(255,110,130,155),")

    local str1 = table.concat(paramArr, nt2) .. "\n\t})"
    local str2 = strFmt_(":addTo(%s)", _setParentNm(dt.parent))
    if dt.visible == "false" or dt.visible == false then
        str2 = str2 .. nt .. ":setVisible(false)"
    end
    
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
        headStr = strFmt_([[local %s = ab.import(".%s.view.%s", "able.module")]], dt.itemName, dt.moduleName, dt.itemName)
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
    if dt.visible == "false" or dt.visible == false then
        str2 = str2 .. nt .. ":setVisible(false)"
    end

    local str3 = strFmt_([[:addScrollNode(display.newNode())]], dt.name)

    return table.concat({str1, str2, str3}, nt)
end

function gen_tab(dt)
    local ax, ay = dt.ax, dt.ay
    local x, y = dt.x, dt.y
    local w, h = dt.width, dt.height

    -- 坐标转化为锚点(0，0)
    x, y = x - ax * w, (y - ay * h)
    local arr = {}
    table.insert(arr, strFmt_("local params = self:getMenuParams()"))
    table.insert(arr, strFmt_("local %s = UIUtil:createUICheckBoxButtonGroup(params)", dt.name))

    table.insert(arr, strFmt_(":setPosition(%s, %s)", x, y))
    table.insert(arr, strFmt_(":addTo(%s, 99)", _setParentNm(dt.parent)))

    return table.concat(arr, nt)
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
