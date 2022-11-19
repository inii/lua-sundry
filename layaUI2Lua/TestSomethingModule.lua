-- 测试一些效果模块
local TestSomethingModule = class("TestSomethingModule", UIModule)

function TestSomethingModule:ctor()
	TestSomethingModule.super.ctor(self)
	-- self._root:pos(display.cx, display.cy)
	
	self:initUI(self._root)
end

function TestSomethingModule:dispose()
	self._root:removeChildByName("layerColorBg", true)
	TestSomethingModule.super.dispose(self)
	if(DEBUG > 0) then
		ab.uninstall("TestSomethingModule")
	end
end

function TestSomethingModule:doLoad(loadData)
	TestSomethingModule.super.doLoad(self,loadData)
	UIManager:addUIShowEffect(self._root, handler(self, self.closeClick), 220, nil, nil , nil, 0, 0)
end

function TestSomethingModule:initUI(root)
	local node_ = display.newNode():pos(0, 0):addTo(root)

	local img_bg = display.newScale9Sprite("image/common2/bg_alert1.png", 0, 670, cc.size(580, 670), cc.rect(373, 15, 1, 1))
	:addTo(node_)
	:setAnchorPoint(0, 1)

	local img_title_bg = display.newScale9Sprite("image/common2/bg_alert_titleBg2.png", 0, 677, cc.size(580, 49), cc.rect(161, 37, 1, 1))
	:addTo(img_bg)
	:setAnchorPoint(0, 1)

	local color = GameUtil:parseColor3b("#f3ecec")
	local lab_title = display.newTTFLabel({text = getLang("activity_1663"), size = 26, font = display.FONT_THICK, color = color})
	:addTo(img_title_bg)
	:setAnchorPoint(0.5, 0.5)
	:pos(290, 25)

	local btn_close = display.newUIPushButton({skins = "image/common2/btn_close5.png",
						handler = handler(self, self.closeClick),
						btnSize = {68, 67},
						x = 544, y = 23,
						parent = img_title_bg,})

	local img_list_bg = display.newScale9Sprite("image/common2/input_bg.png", 10, -4, cc.size(560, 612), cc.rect(7, 5, 1, 1))
	:addTo(img_title_bg)
	:setAnchorPoint(0, 1)

	local Act12116GiftCell = ab.import(".activityModule.view.Act12116GiftCell", "able.module")
	local listParams = {
		parent = img_title_bg,
		viewRect = cc.rect(15, -611, 550, 600),
		isDebug = true,
		cellClass = Act12116GiftCell,
		itemSize = cc.size(550,135),
	}

	local listview=UIUtil:createListview({len=3}, listParams)
	listview:reload()

	local rich_1 = cc.ui.UIRichText.new()
	:addTo(img_bg)
	:setContentSize(292, 73)
	:ignoreContentAdaptWidth(false)
	:setVirticalSpace(1)
	:setAnchorPoint(0, 1)
	:pos(160, 376)
	:setString(getLang("activity_1811"), 18)

						
end

function TestSomethingModule:onBtnHandler(event)
	TipsWordManager:showKey("navigation_trade_31")
	ModuleManager:close(self:getModuleName())
end

function TestSomethingModule:closeClick(event)
	ModuleManager:close(self:getModuleName())
end


return TestSomethingModule