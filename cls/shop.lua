local shop = Class("shop")

local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"
local Bg = require "cls/bg"
local Button = require "cls/button"
local Info = require "cls/info"


local normal = love.graphics.newImage("res/assets/cardback.png")
local silver = love.graphics.newImage("res/assets/cardbacksilver.png")
local gold = love.graphics.newImage("res/assets/cardbackgold.png")
--350,512
function shop:init(parent)
	self.parent = parent
	self.bg = Bg("storeBg")
	self.bg.scale = 2
	self.font = love.graphics.newFont(30)
	self.info = Info(self)
	self.data = self.info.data
	self.packs = {
		{x=-300,y=-50,img=normal},
		{x=0,y=-50,img=silver},
		{x=300,y=-50,img=gold},
	}

	self.ui = {}
	--(parent,x,y,w,h,text)
	self.buys = {
		Button(self,-300,150,100,50,"100 gold") ,
		Button(self,0,150,100,50,"500 gold") ,
		Button(self,300,150,100,50,"1 gem") ,
	}
	self.buys[1].onClick = function() 
		--if self.data.gold<100 then return end
		self.data.gold = self.data.gold -100
		self.selected = self.packs[1]
		self.packs = {}
		--Tween.new(duration, self, {[k]=v}, easing, delay)
		self.selected.tween = Tween.new(0.5,self.selected,{x=0,y=-50},"inQuad",0.3)
	end

	Button(self,500,300,100,50,"back")
end


function shop:toBuilder()
	gamestate.switch(gameState.inter,gameState.libBuilder,nil,nil,self.data) 
end

function shop:update(dt)
	self.mousex, self.mousey = self.parent.camera:mousepos() 

	
	for i,v in ipairs(self.ui) do
		v:update(dt)
	end

	if self.selected then
		self.selected.tween:update(dt)
	end
end



function shop:draw()

	self.bg:draw()
	self.info:draw()
	for i,v in ipairs(self.ui) do
		v:draw()
	end

	love.graphics.setColor(255, 255, 255, 255)
	for i,v in ipairs(self.packs) do
		for i = 1,3 do
			love.graphics.draw(v.img, v.x+i*5, v.y+i*5, 0, 0.5, 0.5, 175,256)
		end
	end
	local selected = self.selected
	if selected then
		for i = 1,3 do
			love.graphics.draw(selected.img, selected.x+i*5, selected.y+i*5,
			 0, 0.5, 0.5, 175,256)
		end
	end

end

return shop