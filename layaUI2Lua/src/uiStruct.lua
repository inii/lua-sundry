module(..., package.seeall)

local function _getXY(dt)
    if not dt then
        print("not prop")
    end

    local x, y = dt.x or 0, dt.y or 0
    if x == 0 then
        print(dt.var .. " x no assign")
    end
    if y == 0 then
        print(dt.var .. " y no assign")
    end

    local parent = dt.parent
    if (parent and parent.height) then
        y = parent.height - y
    end

    return x, y
end

local function _getWH(dt)
    local w, h = dt.width, dt.height
    local url = dt.skin
    if not url or url == "" then
        print((dt.var or dt.type), " not url")
        return w or 0, h or 0
    end

    if not w or not h then
        local resDir = PathCfg.codePorj.res
        local rawW, rawH = kit.getImageSize(resDir .. "/" .. url)
        w = w or rawW
        h = h or rawH
    end

    return w, h
end

local function _getItem(v)
    local child = v and v.child and v.child[1]
    if not child or not child.source then
        return
    end

    local url = table.concat({PathCfg.uiProj.pages, child.source}, "/")
    local tab = json.decode(kit.readFile2Str(url))

    local props = tab and tab.props
    if not props then return end

    local moduleName, itemName = string.match(child.source, "^(.+)/([^/]+)%.ui$")
    return moduleName, itemName, props.width, props.height
end

local NodeStruct = {
    -- @raw ui data from json
    new = function(uitype, raw)
        if not raw then
            print("not raw ui data")
            return
        end

        local x, y = _getXY(raw)
        local w, h = _getWH(raw)

        return {
            x = x,
            y = y,
            ax = raw.anchorX or 0,
            ay = raw.anchorY or 1,
            width = w,
            height = h,
            name = raw.var,
            scaleX = raw.scaleX, -- no default value
            scaleY = raw.scaleY,
            rt = raw.rotation, -- no default value
            parent = raw.parent,
            uitype = uitype
        }
    end
}

local ImgStruct = {
    new = function(uitype, raw)
        local node = NodeStruct.new(uitype, raw)
        node.skin = raw.skin -- pic path
        node.sizeScale9 = raw.sizeGrid -- scale9

        return node
    end
}

local LabStruct = {
    new = function(uitype, raw)
        local node = NodeStruct.new(uitype, raw)
        if raw.parent.uitype == "btn" then
            node.ax = 0.5
            node.ay = 0.5
            node.x = 0
            node.y = 0
        end

        node.font = raw.font
        node.fontSize = raw.fontSize or 18
        node.color = raw.color or "#ffffff"
        node.text = raw.text

        return node
    end
}

local ListStruct = {
    new = function(uitype, raw)
        local node = NodeStruct.new(uitype, raw)

        --  listview item 
        local mNm, nm, w, h = _getItem(raw)
        node.moduleName = mNm 
        node.itemName = nm 
        node.itemW = w
        node.itemH = h

        return node
    end
}

UITypes = {
    node = NodeStruct,
    img = ImgStruct,
    btn = ImgStruct,
    lab = LabStruct,
    rich = LabStruct,
    lsv = ListStruct
}

function createStruct(v)
    -- prefix : UIType   "btnClick" -> "btn"
    local prefix = UITypes[v.var] and v.var or string.match(v.var, "^(%l+)")
    if prefix and UITypes[prefix] then
        return UITypes[prefix].new(prefix, v)
    else
        print(v.var, "undefined ui type: " .. (prefix or v.type or ""))
    end
end
