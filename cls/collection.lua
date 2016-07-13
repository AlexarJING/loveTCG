local collection = Class("collection")
local Button = require "cls/button"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Bg = require "cls/bg"

local function getPos(self,index,level)
	local x = self.x + (index-1)%8*120 + (level-1)*5
	local y = self.y + 180*math.floor(index/8) + (level-1)*5
	return {x=x,y=y}
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
					local card =Card(self.parent,cardData.short[id],nil,getPos(self,index,level))
					card.index = index
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
		local btn =  Button(self,self.x+i*150,self.y-130,80,30,category)
		btn.onClick = function(btn) self.category = btn.text end
		self.categoryBtn[category] = btn
	end

end


function collection:update(dt)
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


function collection:draw()
	
	for i,btn in ipairs(self.buttons) do
		btn:draw()
	end
	for id,tab in pairs(self.cards[self.faction][self.category]) do
		for level,card in ipairs(tab) do
			card:draw()
		end
	end
end

return collection