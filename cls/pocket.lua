local pocket = Class("pocket")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

local collection
local selector

local function getPos(self,index)
	local x = self.x + (index-1)%5*150 
	local y = self.y + 100*math.ceil(index/5 -1)
	return x,y
end

local function getPosForCollection(self,index,level)
	local x = -150 + (index-1)%7*120 + (level-1)*5
	local y = -200 + 180*math.ceil(index/7-1) + (level-1)*5
	return x ,y 
end

local function getPosForCoin(self,index)
	local x = -150 + (index-1)%8*100 
	local y = -200 + 130*math.ceil(index/8-1) 
	return x ,y 
end

function pocket:init(parent)
	self.parent = parent
	self.userdata= parent.userdata
	
	self.x = -100
	self.y = 150
	self.scale = 0.5
	
	self.slot = {}
	self.slot2 = {}
	self:load()
end

function pocket:load()
	collection = self.parent.collection
	selector = self.parent.selector
	local faction = selector.faction
	local category = collection.category
	local hero = selector.hero
	local data = self.userdata
	local cards = collection.cards
	local coins = collection.coins
	

	self.show = collection.show

	for i = 1,10 do		
		local c = self.slot[i]
		if c then
			self.slot[i] = nil
			c.slot = nil
			c.current = collection
			local x,y = getPosForCollection(self,c.index,c.level)
			c.x=x 
			c.y=y
		end
	end

	for i = 1,10 do		
		local c = self.slot2[i]
		if c then
			self.slot2[i] = nil
			c.slot = nil
			c.current = collection
			local x,y = getPosForCoin(self,c.index)
			c.x=x 
			c.y=y
		end
	end

	for i,d in ipairs(data.heros[faction][hero].lib) do
		local card = cards[faction][d.category][d.id][d.level]
		local x, y = getPos(self,i)
		card.current = self
		card.slot = i
		card.x=x 
		card.y=y
		self.slot[i]=card
	end

	for i,v in ipairs(data.heros[faction][hero].deck) do
		for j = i , #coins do
			if v == coins[j].id then
				local card = coins[j]
				local x, y = getPos(self,i)
				card.current = self
				card.slot = i
				card.x=x 
				card.y=y
				self.slot2[i]=card
				break
			end
		end	
	end

	self:save()
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
		local x,y = getPosForCoin(self,hoverCard.index)
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
	local complet = true
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
		else
			complet = false
		end
	end

	local data2 = {}
	for i = 1, 10 do
		if self.slot2[i] then
			local card= self.slot2[i]
			table.insert(data2 , card.id)
		end
	end

	local faction = self.parent.selector.faction
	local hero = self.parent.selector.hero
	local lib = data
	local deck = data2

	self.userdata.heros[faction][hero].lib = lib
	self.userdata.heros[faction][hero].deck = deck
	self.userdata.currentHero = {id = hero , faction = faction}

	if complet then
		local playerdata = {
			faction = faction,
			hero = hero,
			lib = lib,
			deck = deck,
			range = self.parent.info.data.range
		}

		self.parent.playerdata = playerdata
	end
	self.parent.info:saveUserFile()
	
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