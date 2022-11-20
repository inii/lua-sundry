-- 开服狂送金币单元格
local Replace_Name = class("Replace_Name", function ()
	return display.newNode()
end)

function Replace_Name:ctor(cfg)
	-- self.__able_guid = self.__able_guid or ab.getAbleGuid() --自定义对象的唯一ID

	self:initUI()
end

function Replace_Name:dispose()
	-- SchedulerCaller:removeCaller(self.__able_guid)
	-- for k, v in pairs(self._items) do
	-- 	v:unload()
	-- end
end

-- 初始化UI
function Replace_Name:initUI()
	self:auotUI();

	-- 在下面写你的ui代码
	
end

-- 请勿手动修改autoUI内容 (自动生成的，可能被替换)
function Replace_Name:auotUI()

end

--更新按钮状态
function Replace_Name:updateBtnState()
	local leftTime = self._leftTime - (GameUtil:getTimerS() - self._startTime)
	if(leftTime <= 0) then
		self._canGet = true
		self._btn:setGray(false)
		SchedulerCaller:removeCaller(self.__able_guid)
	else
		self._canGet = false
		self._btn:setGray(true)
		
--		self._desLabel2:setString(GameUtil:formatTime5(leftTime))
	end
end

function Replace_Name:updateCellBg()
	if self._sp ~= nil then
		self._sp:removeFromParent()
		self._sp = nil
	end
	if self._curIndex >= 5 then
		self._sp = display.newScale9Sprite("image/activity/act_1002_cellBg2.png",0,0,cc.size(self._bgW, self._bgH), UIUtil.CELL_SCALE9_1)
		:addTo(self._bg, -1)
		:pos(self._bgW / 2, self._bgH / 2)
	else
		self._sp = display.newScale9Sprite("image/activity/act_1002_cellBg1.png",0,0,cc.size(self._bgW, self._bgH), UIUtil.CELL_SCALE9_1)
		:addTo(self._bg, -1)
		:pos(self._bgW / 2, self._bgH / 2)
	end
end

-- 更新总奖励展示
function Replace_Name:updateRewards(arr)
	local item
	local len = #arr -- 对应奖励个数
	for i = 1, len do
		item = self._items[i]
		if not item then
			item = ItemCompoment.new()
			item:addTo(self._bg)
			item:pos(178 + (i - 1) * 105, self._bgH / 2)
			table.insert(self._items, item)
		end
		item:setItemDatas(arr[i][1], arr[i][2])
		item:setVisible(true)
	end
	
	local arrLen = #self._items
	for i = len + 1, arrLen do
		item = self._items[i]
		item:setVisible(false)
	end
end

-- 点击按钮操作
function Replace_Name:onBtnClickHandler(event)
	if(self._canGet) then
		if ABROAD ~= nil then
			--领取第4档,第6档,写一条在线礼包事件
			if self._curIndex == 1 then
				RoleManager:checkMarkEvent(GameDef.TYPE_FANTI_EVENT9)
			elseif self._curIndex == 4 then
				SDKManager:invokeSDKOnGLThread("efunEventTrack", {event="online_rewards_4",roleId=tostring(RoleManager:getRoleId()),roleLevel=tostring(RoleManager:getLevel())})
			elseif self._curIndex == 6 then
				SDKManager:invokeSDKOnGLThread("efunEventTrack", {event="online_rewards_6",roleId=tostring(RoleManager:getRoleId()),roleLevel=tostring(RoleManager:getLevel())})
				if GameUtil:isFanti() then -- 繁体
					if GameUtil:isFantiGloal() then
						SDKManager:invokeSDKOnGLThread("fantiStandardEvent", {type=GameDef.TYPE_EVENT4_GLOALl_STANDARD})
						SDKManager:invokeSDKOnGLThread("fantiAdjustEvent", {name=GameDef.TYPE_EVENT4_GLOALl})
					else
						SDKManager:invokeSDKOnGLThread("fantiEvent", {name="event4",value=""})
						SDKManager:invokeSDKOnGLThread("fantiAdjustEvent", {name="th1qbo",value=""})
					end
				end
			end
		end
		
		ActivityManager:reqActRewardDrawReq(GameDef.ACTIVITY_ONLINE_ID, self._curIndex)
	else
		TipsWordManager:showKey("online_4")
	end
end

return Replace_Name