local builder = Class("builder")
local Button = require "cls/button"
local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"

local factions = {"vespitole","daramek","endazu","metris"}
local heros={
	vespitole = {
		"captainviatrix",
		"sofocatro",
		"sisterYsadora",
		"cardinalpocchi"
	}
}

local category={
	vespitole = {"power","prosperity","faith","war","coin"}
}


function builder:init()
	---to remove---
	self.cardSet = {}
	for faction,tab in pairs(cardData) do
		self.cardSet[faction]={}
		for id,dat in pairs(tab) do
			self.cardSet[faction][id] = {faction = faction,id = id, exp =0, level = 3}
		end
	end

	self.bg = require "cls/bg"("vespitoleBg")
	self.buttons={}
	self.font_title = love.graphics.newFont(30)
	self.font_content = love.graphics.newFont(20)

	self.heroCards = {}
	self.heroPos = {
		x=-400,
		y=0,
		scale= 1.3
	}

	for faction,tab in pairs(heros) do
		self.heroCards[faction] = {}
		for i,id in pairs(tab) do
			self.heroCards[faction][i] = Card(self,cardData[faction][id],_,self.heroPos)
		end
	end

	self.currentFactionIndex = 1
	self.currentHeroIndex = 1
	self.currentCategoryIndex = 1

	self.currentHero = self.heroCards[factions[self.currentFactionIndex]][self.currentHeroIndex]

	local button_v = Button(self,-600,-300,80,30,"vispitole")
	local button_m = Button(self,-500,-300,80,30,"metris")
	local button_d = Button(self,-400,-300,80,30,"daramek")
	local button_e = Button(self,-300,-300,80,30,"endazu")

	local button_prev = Button(self,-500,250,80,30,"prev")
	local button_next = Button(self,-400,250,80,30,"next")

	for i,cat in ipairs(category[factions[self.currentFactionIndex]]) do
		Button(self,-150+ i*120, -300 ,100,40,cat)
	end

	local index = 0
	for id,data in pairs(self.cardSet[factions[self.currentFactionIndex]]) do
		if cardData[factions[self.currentFactionIndex]][id].caterory 
			== category[factions[self.currentFactionIndex]][self.currentCategoryIndex] then

		end
	end
end


function builder:update(dt)
	for i,b in ipairs(self.buttons) do
		b:update(dt)
	end
	self.currentHero:update(dt)
end


function builder:draw()
	self.bg:draw()
	for i,b in ipairs(self.buttons) do
		b:draw()
	end
	self.currentHero:draw()
end

return builder