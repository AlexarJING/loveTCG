local debug = Class("debug")
local Card = require "cls/card"

local function getPos(self,index,level)
	local x = -500 + 50*(index%20)
	local y = -300 + 70*math.floor(index/20)
	return x ,y 
end

function debug:init(game,root)
    self.game = game
    self.cards={}

	local index =0
	for faction,tab in pairs(game.cardData) do	
		if faction == "short" or faction == "index" or faction == "rarity" then
			-----
		elseif faction == "coins" then
			for id,data in pairs(tab) do
				index = index + 1		
				local cd = table.copy(game.cardData.short[id])
				local card =Card(self,cd,nil,self)
				card.current = self
				card.x,card.y = getPos(self,index,level)
				self.cards[index] = card					
			end
		else
			for category, d in pairs(tab) do
				if category == "hero" or category == "coin" then
				-------
				else
					for id,data in pairs(d) do
						index = index + 1		
						local cd = table.copy(game.cardData.short[id])
						local card =Card(self,cd,nil,self)
						card.current = self
						card.x,card.y = getPos(self,index,level)
						self.cards[index] = card					
					end

				end
			end
		end
	end

	self.enable = false
end

function debug:rightClick(card)
	self.game:refillCard("my",card.data)
	self.enable = false
end

function debug:click(card)
	local copy = self.game:makeCard(card.data)
	self.game:drawCard("my",copy)
	self.enable = false
end

function debug:update(dt)
	if not self.enable then return end
    self.mousex , self.mousey = self.game.mousex , self.game.mousey
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
    if self.hoverCard then self.game.hoverCard = self.hoverCard end
end

function debug:draw()
	if not self.enable then return end
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end


return debug
