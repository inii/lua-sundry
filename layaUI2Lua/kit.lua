

local lfs = require("lfs")
local kit = {}

function kit.log(content)
    print(string.match(debug.traceback(), "stack traceback:%s+(.*) in main chunk"), content)

end

function kit.writeStr2File(path, str, mod)
    local f = assert(io.open(path, mod or 'w'), path)

    f:write(str)
    f:flush()
    f:close()
end

function kit.readFile2Str(path)
    local f = assert(io.open(path, "r"), path)

    local lines = f:read("*all")
    f:close()
    return (lines)
end

function kit.parse2Num(srcStr, arr)
    arr = arr or {}
    local num, str = string.match(srcStr, "(%d+),?(.*)")

    if num then
        table.insert(arr, num)
    end

    if str then
        kit.parse2Num(str, arr)
    end

    return arr
end

-- 获取图片尺寸
function kit.getImageSize(url)
    if not kit.gd then
        kit.gd = require("gd")
    end

    local gd, img = kit.gd
    local subfix = string.sub(url, -3, -1)
    if subfix == "png" then
        print("create img with png", url)
        img = gd.createFromPng(url)
    elseif subfix == "jpg" then
        print("create img with jpg", url)
        img = gd.createFromJpeg(url)
    else
        print("warn: unknown type when getImageSize")
    end

    if not img then
        print("create image failed.", url)
    end

    return img:sizeXY()
end





-- 处理目录下的所有文件
function kit.handFileInDir(path, handler)
    local url, attr
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            url = path .. '/' .. file
            attr = lfs.attributes(url)
            if attr.mode == "directory" then
                print(url .. "  -->  " .. attr.mode)
                kit.handFileInDir(url, handler)
            else
                print(url .. "  -->  " .. attr.mode)
                if handler then
                    handler(url, file)
                end
            end
        end
    end
end

-- 检测路径是否目录
function kit.is_dir(sPath)
    if type(sPath) ~= "string" then
        return false
    end

    local attr = lfs.attributes(sPath)
    if not attr then
        return false
    end

    return attr.mode == "directory"
end

-- 文件是否存在
function kit.file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

-- 获取文件路径
function getFileDir(filename)
    return string.match(filename, "(.+)/[^/]*%.%w+$") -- *nix system
end

-- 获取文件名
function strippath(filename)
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system
end

-- 去除扩展名
function stripextension(filename)
    local idx = filename:match(".+()%.%w+$")
    if (idx) then
        return filename:sub(1, idx - 1)
    else
        return filename
    end
end

-- 获取扩展名
function getExtension(filename)
    return filename:match(".+%.(%w+)$")
end

-- 字符串分割
function string.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == '') then
        return false
    end
    local pos, arr = 0, {}
    -- for each divider found
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

-- 去空格
function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

-- table转string
function tableToString(value, desciption, nesting)
    if type(nesting) ~= "number" then
        nesting = 7
    end
    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local function _dump(value, desciption, indent, nest, keylen)
        desciption = desciption or "var"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(desciption))
            -- spc = string.rep(" ", keylen - string.len(_v(desciption)))
        end
        if type(value) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s", indent, desciption, spc, _v(value))
            -- result[#result +1 ] = string.format("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
        elseif lookupTable[value] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent, desciption, spc)
        else
            lookupTable[value] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, desciption)
            else
                result[#result + 1] = string.format("%s%s = {", indent, desciption)
                -- result[#result +1 ] = string.format("%s%s = {", indent, _v(desciption))
                local indent2 = indent .. "    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = _v(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then
                        keylen = vkl
                    end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    _dump(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result + 1] = string.format("%s}", indent)
            end
        end
    end
    _dump(value, desciption, "\n", 1)
    -- _dump(value, desciption, "- ", 1)
    return result
end

-- 打印table
function dump(value, desciption, nesting)
    local traceback = string.split(debug.traceback("", 2), "\n")
    print("dump from: " .. string.trim(traceback[3]))

    local result = tableToString(value, desciption, nesting)
    for i, line in ipairs(result) do
        print(line)
    end
end

return kit
