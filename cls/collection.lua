local collection = Class("collection")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

local function getPos(self,index,level)
	local x = self.x + (index-1)%8*120 + (level-1)*5
	local y = self.y + 180*math.floor(index/8) + (level-1)*5
	return x ,y 
end

local function getPosForPocket(self,index)
	local x = -100 + (index-1)%5*150 
	local y = 150 + 100*math.ceil(index/5 -1)
	return x,y
end

function collection:init(parent)
	self.parent = parent
	self.userdata= parent.userdata
	self.x = -150
	self.y = -200
	self.scale = 0.5
	
	self.hero = self.parent.hero
	self.faction = self.parent.faction


	self.cards={}
	for faction,tab in pairs(self.userdata.cards) do	
		self.cards[faction]={}
		for category, d in pairs(tab) do
			local index =0
			self.cards[faction][category]={}
			for id,data in pairs(d) do
				self.cards[faction][category][id]={}
				index = index + 1
				for level = 1 , data.level do
					local cd = table.copy(cardData.short[id])
					cd.level = level
					cd.exp = data.exp
					local card =Card(self.parent,cd,nil,self)
					card.index = index
					card.x,card.y = getPos(self,index,level)
					self.cards[faction][category][id][level] = card
				end
					
			end
		end
	end
	self.buttons = {}

	self.categoryBtn ={}
	local i = 0
	for category,data in pairs(self.cards[self.faction]) do
		self.category = self.category or category
		i = i + 1
		local btn =  Button(self,self.x+i*150 ,self.y-130,80,30,category)
		btn.onClick = function(btn) 
			self.category = btn.text 
			self.parent.category = btn.text
		end
		self.categoryBtn[category] = btn
	end
	self.parent.category = self.category

	local btn = Button(self,self.x, self.y - 130, 80,30, "save")
	btn.onClick = function()
		self.parent.state = "menu"
		self.parent.pocket:save()
	end
end


function collection:update(dt)
	local faction = self.parent.faction
	local hero = self.parent.hero
	local category = self.category


	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	for i,btn in ipairs(self.buttons) do
		btn:update(dt)
	end

	for id,tab in pairs(self.cards[faction][category]) do
		for level,card in ipairs(tab) do
			if not card.slot then
				card:update(dt)
			end
		end
	end

	local hoverCard = self.parent.hoverCard
	local pocket = self.parent.pocket
	if hoverCard and self.parent.click and  hoverCard.current == self then			
		local pos
		for i = 1, 10 do
			if pocket.slot[i]==nil then
				pos = i
				break
			end
		end
		if not pos then return end
		hoverCard.slot = pos
		pocket.slot[pos] = hoverCard
		hoverCard.current = pocket
		local x,y = getPosForPocket(self,hoverCard.slot)
		hoverCard:addAnimate(0.5,{x=x,y=y},"inBack")
		self.parent.click = false
	end
end


function collection:draw()
	
	local faction = self.parent.faction
	local hero = self.parent.hero
	local category = self.category

	for i,btn in ipairs(self.buttons) do
		btn:draw()
	end
	for id,tab in pairs(self.cards[faction][category]) do
		for level,card in ipairs(tab) do
			card:draw()
		end
	end
end

return collection