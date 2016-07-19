local result = Class("result")
local Bg = require "cls/bg"
local font = love.graphics.newFont(30)
local Frag = require "lib/frag"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Fire = require "lib/firework"

function result:init(parent,hero,result)
	self.result = result
	self.bg = Bg("stoneBg")
	self.parent = parent
	self.cards = {}
	--[[
	self.hero = hero or Card(self,cardData.short.sofocatro,nil,{x=-300,y=300})
	self.hero:addAnimate(1,{x=0},"inQuad",nil)
	self.hero:addAnimate(1,{y=0},"inQuad",nil)
	if result == "win" then
		self.hero:addAnimate(1,{scale=1},"inQuad",nil,function() self:breakout() end)
	else
		self.hero:addAnimate(1,{scale=1},"inQuad",nil,function() self:breakout() end)
	end]]
	 --addAnimate(duration , target , easing , delay, callback)
	self.firework = Fire(0,400,3,-10,2) --x,y,dx,dy,size,time,img
end


function result:breakout()
	local cb = function()
		self.frag = Frag(self.hero.x,self.hero.y,0,self.hero.predraw) 
		self.hero = nil
		self.parent.camera:shake()
		self.showResult = true
	end
	self.hero:vibrate(nil,nil,cb)
end


function result:update(dt)
	self.mousex,self.mousey = self.parent.camera:mousepos()
	if self.hero then self.hero:update(dt) end
	if self.frag then self.frag:update(dt) end
	self.firework:update(dt)
end



function result:draw()
	self.bg:draw()
	if self.hero then self.hero:draw() end
	if self.frag then self.frag:draw() end

	love.graphics.setColor(255, 255, 255, 255)
	if self.showResult then
		if self.result == "lose" then
			love.graphics.printf("YOU LOSE !", -360,0, 360, "center", 0, 2, 2)
		else
			love.graphics.printf("YOU WIN !", -360,0, 360, "center", 0, 2, 2)
		end
	end
	self.firework:draw()
end

return result