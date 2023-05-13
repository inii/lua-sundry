local Replace_Name = class("Replace_Name", BasePage)

function Replace_Name:ctor(container, info)
	Replace_Name.super.ctor(self, container)
	self._parentC = container
	-- self._actInfo = info
	-- self._actId = info.id
	-- self._dangCi = info.dangCi > 0 and info.dangCi or 1
	
	self:initUI()
end

function Replace_Name:load()
	Replace_Name.super.load(self)
end

-- 显示界面
function Replace_Name:showPage()
	Replace_Name.super.showPage(self)
	-- self:updatePanel()
end

-- 关闭界面
function Replace_Name:hidePage()
	Replace_Name.super.hidePage(self)
end

function Replace_Name:dispose()
	-- SchedulerCaller:removeCaller("Replace_Name:updateLeftTime")
	
	-- GameUtil:cleanListView(self._list)
	-- self._list = nil
	
	Replace_Name.super.dispose(self)
	
	-- if(DEBUG > 0) then
		-- ab.uninstall("Act1002Cell")
	-- end
end

function Replace_Name:initUI()
	self:autoUI()

	-- 在下面写你的ui代码
end

-- 请勿手动修改autoUI内容 (自动生成的，可能被替换)
function Replace_Name:autoUI()

end


return Replace_Name