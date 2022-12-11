return  
"-- 测试一些效果模块\
local TestSomethingModule = class(\"TestSomethingModule\", UIModule)\
\
function TestSomethingModule:ctor()\
	TestSomethingModule.super.ctor(self)\
	-- self._root:pos(display.cx, display.cy)\
	\
	self:initUI(self._root)\
end\
\
function TestSomethingModule:dispose()\
	self._root:removeChildByName(\"layerColorBg\", true)\
	TestSomethingModule.super.dispose(self)\
	if(DEBUG > 0) then\
		ab.uninstall(\"TestSomethingModule\")\
	end\
end\
\
function TestSomethingModule:doLoad(loadData)\
	TestSomethingModule.super.doLoad(self,loadData)\
	UIManager:addUIShowEffect(self._root, handler(self, self.closeClick), 220, nil, nil , nil, 0, 0)\
end\
\
function TestSomethingModule:initUI(root)\
%s					\
end\
\
function TestSomethingModule:onBtnHandler(event)\
	TipsWordManager:showKey(\"navigation_trade_31\")\
	ModuleManager:close(self:getModuleName())\
end\
\
function TestSomethingModule:closeClick(event)\
	ModuleManager:close(self:getModuleName())\
end\
\
\
return TestSomethingModule"


	-- self._bg = display.newSprite(\"image/rtsBattle/alertBg1.png\")\
	-- :addTo(root)\
    -- :pos(display.cx, display.cy)\
	-- :setTouchEnabled(true)\

	-- 关闭按钮\
	-- display.newUIPushButton({\
    --                         handler = handler(self, self.closeClick),\
    --                         skins = \"image/rtsBattle/btnClose.png\",\
    --                         parent = self._bg,\
    --                         x = 460 - 25,\
    --                         y = 278 - 22,\
	-- 						})\
