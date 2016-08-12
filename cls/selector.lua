local selector = Class("selector")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

function selector:init(parent)
	self.parent = parent
	self.userdata= parent.userdata
	self.x = -400
	self.y = 0
	self.scale = 1.3
	
	self.currentFaction = self.userdata.currentHero.faction
	self.currentID = self.userdata.currentHero.id
	self.bg = Bg(self.currentFaction.."Bg",0,0,1.1)

	self.parent.faction = self.currentFaction
	self.parent.hero = self.currentID

	self.heros={}
	for faction,tab in pairs(self.userdata.heros) do
		local index =0
		self.heros[faction]={}
		for id, d in pairs(tab) do
			index = index + 1
			self.heros[faction][index] = Card(self.parent,cardData[faction].hero[id],nil,self)  --game,data,born,current
	
			if id == self.currentID then
				self.currentIndex = index
			end
		end
	end
	self.currentHero = self.heros[self.currentFaction][self.currentIndex]

	self.ui = {}

	self.factionBtn = {
		vespitole = Button(self,-550,-250,80,30,"vespitole"),
		metris = Button(self,-450,-250,80,30,"metris"),
		daramek = Button(self,-350,-250,80,30,"daramek"),
		endazu =Button(self,-250,-250,80,30,"endazu")
	}

	for faction,btn in pairs(self.factionBtn) do
		if #self.heros[faction]==0 then
			btn.enable = false
		end
		btn.onClick = function(btn)
			self.parent.pocket:save()
			self.currentFaction = btn.text
			self.currentIndex = 1
			self.bg = Bg(btn.text.."Bg",0,0,1.1)
			self.currentHero = self.heros[self.currentFaction][self.currentIndex]
			self.parent.faction = self.currentFaction
			self.parent.hero = self.currentHero.id
			self.parent.pocket:load()
			self.parent.collection:resetBtn()
		end
	end

	self.prevBtn = Button(self,-450,250,80,30,"prev")
	self.prevBtn.onClick = function()
		self.parent.pocket:save()
		self.currentIndex = self.currentIndex + 1
		if not self.heros[self.currentFaction][self.currentIndex] then
			self.currentIndex = 1
		end
		self.currentHero = self.heros[self.currentFaction][self.currentIndex]
		self.parent.hero = self.currentHero.id
		--self.parent.pocket:save()
		self.parent.pocket:load()
	
	end
	self.nextBtn = Button(self,-350,250,80,30,"next")
 	self.nextBtn.onClick = function()
 		self.parent.pocket:save()
 		self.currentIndex = self.currentIndex - 1
		if not self.heros[self.currentFaction][self.currentIndex] then
			self.currentIndex = #self.heros[self.currentFaction]
		end
		self.currentHero = self.heros[self.currentFaction][self.currentIndex]
		self.parent.hero = self.currentHero.id
		--self.parent.pocket:save()
		self.parent.pocket:load()
	
 	end
end


function selector:update(dt)
	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	self.hoverUI= nil
	for i,btn in ipairs(self.ui) do
		btn:update(dt)
	end
	self.parent.hoverUI = self.parent.hoverUI or self.hoverUI
end


function selector:draw()
	self.bg:draw()
	for i,btn in ipairs(self.ui) do
		btn:draw()
	end
	self.currentHero:draw()
end

return selector