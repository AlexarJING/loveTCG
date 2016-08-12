local menu = Class("menu")
local Button = require "cls/button"
local Bg = require "cls/bg"

function menu:init(parent)
	self.parent = parent
	self.bg = Bg("title",0,0,2)
	self.bg.color = {0,0,0,255}
	self.ui = {}
	self.x = 500
	self.y = 10

	local journey = Button(self,self.x,-300,250,50,"journey")
	local skirmish = Button(self,self.x,-200,250,50,"skirmish")
	skirmish.onClick = function()
		local test
		for i = 1, 10 do
			if not self.parent.lib[i] then test = true ;break end 
		end
		if test then return end
		gamestate.switch(gameState.game_scene,self.parent) --from,to,time,how,...
	end
	local melee = Button(self,self.x,-100 + self.y,250,50,"melee")
	local arena = Button(self,self.x,0+ self.y, 250,50,"arena")
	local shop = Button(self,self.x, 100+ self.y,250,50,"shop")
	shop.onClick = function()
		gamestate.switch(gameState.inter,gameState.shop_scene)
	end
	local editor = Button(self,self.x,200+ self.y,250,50,"editor")
	editor.onClick = function()
		self.parent:initEditor()
	end
	
	local exit = Button(self,self.x,300+ self.y,250,50,"exit")
	exit.onClick = function()
		love.event.quit()
	end
end


function menu:update(dt)
	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	self.hoverUI= nil
	for i,btn in ipairs(self.ui) do
		btn:update(dt)
	end
	self.parent.hoverUI = self.parent.hoverUI or self.hoverUI
end


function menu:draw()
	self.bg:draw()
	for i,btn in ipairs(self.ui) do
		btn:draw()
	end

end

return menu