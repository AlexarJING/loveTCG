local debug = Class("debug")


local function getPos(self,index,level)
	local x = -500 + 50*(index%20)
	local y = -300 + 70*math.floor(index/20)
	return x ,y 
end

function debug:init(game,root)
    self.game = game
	self.enable = false
	self:loadAll()
end

function debug:loadAll()
	local game = self.game
	self.cards={}

	local index =0
	for faction,tab in pairs(cardData) do	
		if faction == "short" or faction == "index" or faction == "rarity" then
			-----
		elseif faction == "coins" or faction== "summon" then
			for id,data in pairs(tab) do
				index = index + 1		
				local cd = table.copy(cardData.short[id])
				local card =Card(self,cd,nil,self)
				card.current = self
				card.x,card.y = getPos(self,index,level)
				self.cards[index] = card					
			end
		else
			for category, d in pairs(tab) do
				
				for id,data in pairs(d) do
					index = index + 1		
					local cd = table.copy(cardData.short[id])
					local card =Card(self,cd,nil,self)
					card.current = self
					card.x,card.y = getPos(self,index,level)
					self.cards[index] = card					
				end

				
			end
		end
	end
end


function debug:rightClick(card)
	if card.isHero then return end
	self.game:refillCard("my",card.data)
	self.enable = false
	self.game.turnButton.freeze = false
end

function debug:click(card)
	
	if card.isHero then
		self.game.my.hero:setHero({faction=card.faction,hero = card.id})
	else
		local copy = self.game:makeCard(card.data)
		self.game:drawCard("my",copy)
	end
	
	self.enable = false
	self.game.turnButton.freeze = false
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
