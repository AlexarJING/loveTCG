local pocket = Class("pocket")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

local function getPos(self,index)
	local x = self.x + (index-1)%5*150 
	local y = self.y + 100*math.ceil(index/5 -1)
	return x,y
end

local function getPosForCollection(self,index,level)
	local x = -150 + (index-1)%8*120 + (level-1)*5
	local y = -200 + 180*math.floor(index/8) + (level-1)*5
	return x ,y 
end

function pocket:init(parent)
	self.parent = parent
	self.userdata= parent.userdata.collection
	self.collection = self.parent.collection
	self.x = -100
	self.y = 150
	self.scale = 0.5
	
	self.slot = {}
	self.slot2 = {}
	self:load()
	self:save()
end

function pocket:load()
	local faction = self.parent.faction
	local category = self.parent.category
	local hero = self.parent.hero
	local data = self.userdata
	local cards = self.collection.cards
	local coins = self.collection.coins
	local collection = self.collection

	self.show = self.collection.show

	for i = 1,10 do		
		local c = self.slot[i]
		if c then
			self.slot[i] = nil
			c.slot = nil
			c.current = collection
			local x,y = getPosForCollection(self,c.index,c.level)
			c:addAnimate(0.5,{x=x,y=y},"inBack")
		end
	end

	for i = 1,10 do		
		local c = self.slot2[i]
		if c then
			self.slot2[i] = nil
			c.slot = nil
			c.current = collection
			local x,y = getPosForCollection(self,c.index,1)
			c:addAnimate(0.5,{x=x,y=y},"inBack")
		end
	end


	for i,d in ipairs(data.heros[faction][hero].lib) do
		local card = cards[faction][d.category][d.id][d.level]
		local x, y = getPos(self,i)
		card.current = self
		card.slot = i
		card:addAnimate(0.5,{x=x,y=y},"inBack")
		self.slot[i]=card
	end

	for i,v in ipairs(data.heros[faction][hero].deck) do
		for j = i , #coins do
			if v == coins[j].id then
				local card = coins[j]
				local x, y = getPos(self,i)
				card.current = self
				card.slot = i
				card:addAnimate(0.5,{x=x,y=y},"inBack")
				self.slot2[i]=card
				break
			end
		end	
	end
end

function pocket:update_forCoin(dt)
	for i = 1, 10 do 
		if self.slot2[i] then
			self.slot2[i]:update(dt)
		end
	end

	local hoverCard = self.parent.hoverCard
	local collection = self.parent.collection

	if hoverCard and self.parent.click and hoverCard.current == self then						
		self.slot2[hoverCard.slot] = nil
		hoverCard.slot = nil
		hoverCard.current = collection
		local x,y = getPosForCollection(self,hoverCard.index,hoverCard.level)
		hoverCard:addAnimate(0.5,{x=x,y=y},"inBack")
		self.parent.click = false
	end

end



function pocket:update(dt)
	self.faction = self.parent.faction
	self.show = self.parent.collection.show

	if self.show =="coin" then return self:update_forCoin(dt) end

	for i = 1, 10 do 
		if self.slot[i] then
			self.slot[i]:update(dt)
		end
	end

	local hoverCard = self.parent.hoverCard
	local collection = self.parent.collection

	if hoverCard and self.parent.click and hoverCard.current == self then		
					
		self.slot[hoverCard.slot] = nil
		hoverCard.slot = nil
		hoverCard.current = collection
		local x,y = getPosForCollection(self,hoverCard.index,hoverCard.level)
		hoverCard:addAnimate(0.5,{x=x,y=y},"inBack")
		self.parent.click = false
	end
end

function pocket:save()
	local data = {}
	for i = 1, 10 do
		if self.slot[i] then
			local card= self.slot[i]
			table.insert(data,{
				id= card.id,
				faction=card.faction,
				level = card.level,
				exp = card.exp,
				category = card.category})
		end
	end

	local data2 = {}
	for i = 1, 10 do
		if self.slot2[i] then
			local card= self.slot2[i]
			table.insert(data2 , card.id)
		end
	end
	self.userdata.heros[self.parent.faction][self.parent.hero].lib = data
	self.userdata.heros[self.parent.faction][self.parent.hero].deck = data2
	self.parent.lib = data
	self.parent.deck = data2


	local file = love.filesystem.newFile("system", "w")
	file:write(table.save(self.parent.userdata))
	file:close()

end


function pocket:draw()

		
	love.graphics.setColor(0, 0, 0, 100)
	for i = 1, 10 do
		local x,y = getPos(self,i)
		love.graphics.ellipse( "fill", x, y+80, 80, 20 )
	end

	if self.show == "card" then
		for i = 1, 10 do 
			if self.slot[i] then
				self.slot[i]:draw()
			end
		end
	else
		for i = 1, 10 do 
			if self.slot2[i] then
				self.slot2[i]:draw()
			end
		end
	end
end

return pocket