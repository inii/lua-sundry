
local Replace_Name = class("Replace_Name", UIModule)

function Replace_Name:ctor()
	Replace_Name.super.ctor(self)
	self._root:pos(display.cx, display.cy)

	self:initUI()
end

function Replace_Name:doLoad(loadData)
	Replace_Name.super.doLoad(self, loadData)
	self._loadData = loadData
	UIManager:addUIShowEffect(self._root)

end

function Replace_Name:dispose()
	Replace_Name.super.dispose(self)
	if DEBUG > 0 then
		ab.uninstall("Replace_Name")
	end
end

function Replace_Name:doUnLoad()
	Replace_Name.super.doUnLoad(self)
end

-- 
function Replace_Name:initUI()
    self:autoUI()
	
	-- 在下面写你的ui代码

end

-- 请勿手动修改autoUI内容 (自动生成的，可能被替换)
function Replace_Name:autoUI()

end

function Replace_Name:lsvDelegate(listView, tag, index)
    -- if tag == cc.ui.UIListView.COUNT_TAG then
    --     self._dataArr and #self._dataArr or 0
    -- elseif tag == cc.ui.UIListView.CELL_TAG then
    --     local cell, item
    --     item = listView:dequeueItem()
    --     if not item then
    --         item = listView:newItem()
    --         cell = AutoTestGiftCell.new(530, 135)
    --         item:addContent(cell)
    --         item:setItemSize(530, 135)
    --         -- item:setPosition(-265, 135/2)
    --     else
    --         cell = item:getContent()
    --     end

	-- 	-- 通过闭包获取数据
	-- 	cell:setDataCbk = function() 
	-- 		return self and self._dataArr[index]
	-- 	end
	-- 	cell:updateCell()

    --     return item
    -- end
end

--点击关闭按钮
function Replace_Name:closeClick(event)
	ModuleManager:close(self:getModuleName())
end

return Replace_Name