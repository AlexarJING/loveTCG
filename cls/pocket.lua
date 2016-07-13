local pocket = Class("pocket")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

local function getPos(self,index,level)
	local x = self.x + (index-1)%5*120 
	local y = self.y + 180*math.floor(index/5)
	return {x=x,y=y}
end

function pocket:init(parent)
	self.parent = parent
	self.userdata= parent.userdata
	self.x = -150
	self.y = -200
	self.scale = 0.5
	
	self.hero = self.parent.hero
	self.faction = self.parent.faction


end

function pocket:readHeroPocket()
	self.slots = {}
	for i,v in ipairs(self.userdata.heros[self.faction][self.hero.id].deck) do
		print(i,v)
	end


end


function pocket:update(dt)
	self.faction = self.parent.faction
	self.hero = self.parent.hero

	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	for i,btn in ipairs(self.buttons) do
		btn:update(dt)
	end

	for id,tab in pairs(self.cards[self.faction][self.category]) do
		for level,card in ipairs(tab) do
			card:update(dt)
		end
	end
end


function pocket:draw()
	
	for i,btn in ipairs(self.buttons) do
		btn:draw()
	end
	for id,tab in pairs(self.cards[self.faction][self.category]) do
		for level,card in ipairs(tab) do
			card:draw()
		end
	end
end

return pocket