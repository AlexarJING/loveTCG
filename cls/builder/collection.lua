local collection = Class("collection")


local function getPos(self,index,level)
	local x = self.x + (index-1)%7*120 + (level-1)*5
	local y = self.y + 180*math.ceil(index/7-1) + (level-1)*5
	return x ,y 
end

local function getPosForCoin(self,index)
	local x = self.x + (index-1)%8*100 
	local y = self.y + 130*math.ceil(index/8-1) 
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
	self.show = "card"

	self.faction = self.parent.selector.faction

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

	self.coins = {}

	for i,id in ipairs(self.userdata.coins) do
		local cd = table.copy(cardData.short[id])
		local card =Card(self.parent,cd,nil,self)
		card.index = i
		card.x,card.y = getPosForCoin(self,i)
		card.scale = 0.4
		self.coins[i] = card
	end

	self.ui = {}

	self.categoryBtn ={}
	local i = 0
	for category,data in pairs(self.cards[self.faction]) do
		self.category = self.category or category
		i = i + 1
		local btn =  Button(self,self.x+i*100+200 ,self.y-130,80,30,category)
		btn.onClick = function(btn) 
			self.show = "card"
			self.category = btn.text 
			--self.parent.category = btn.text
		end
		self.categoryBtn[category] = btn
	end
	
	i = i + 1 
	local btn =  Button(self,self.x+i*100+200 ,self.y-130,80,30,"coins")
	btn.onClick = function(btn) 
		self.show = "coin"
		self.category = btn.text 

	end
	


	local btn = Button(self,self.x+100, self.y - 130, 80,30, "save")
	btn.onClick = function()
		self.parent.state = "menu"
		self.parent.pocket:save()
	end
end

function collection:resetBtn()
	self.faction = self.parent.selector.faction
	
	for k,v in pairs(self.categoryBtn) do
		v:remove()
	end

	self.categoryBtn ={}
	self.category = nil
	local i = 0
	for category,data in pairs(self.cards[self.faction]) do
		self.category = self.category or category
		i = i + 1
		local btn =  Button(self,self.x+i*100+100 ,self.y-130,80,30,category)
		btn.onClick = function(btn) 
			self.show = "card"
			self.category = btn.text 
		end
		self.categoryBtn[category] = btn
	end

end


function collection:update_forCoin(dt)
	
	for i,card in ipairs(self.coins) do
		if not card.slot then
			card:update(dt)
		end
	end

	local hoverCard = self.parent.hoverCard
	local pocket = self.parent.pocket
	if hoverCard and self.parent.click and  hoverCard.current == self then			
		local pos
		for i = 1, 10 do
			if pocket.slot2[i]==nil then
				pos = i
				break
			end
		end
		if not pos then return end
		hoverCard.slot = pos
		pocket.slot2[pos] = hoverCard
		hoverCard.current = pocket
		local x,y = getPosForPocket(self,hoverCard.slot)
		hoverCard:addAnimate(0.5,{x=x,y=y},"inBack")
		self.parent.click = false
	end

end

function collection:update(dt)

	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	
	self.hoverUI= nil

	for i,btn in ipairs(self.ui) do
		btn:update(dt)
	end

	self.parent.hoverUI = self.parent.hoverUI or self.hoverUI

	if self.show == "coin" then return self:update_forCoin(dt) end

	local faction = self.parent.selector.faction
	local category = self.category

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
	

	local faction = self.parent.selector.faction

	local category = self.category

	for i,btn in ipairs(self.ui) do
		btn:draw()
	end

	

	if self.show == "card" then
		love.graphics.setColor(100, 100, 255, 50)
		for i = 1, 14 do
			local x, y = getPos(self,i,1)
			love.graphics.rectangle("fill", x-55, y-80, 110, 160)
		end
		for id,tab in pairs(self.cards[faction][category]) do
			for level,card in ipairs(tab) do
				card:draw()
			end
		end
	else
		love.graphics.setColor(100, 100, 255, 50)
		for i = 1, 14 do
			local x, y = getPosForCoin(self,i)
			love.graphics.rectangle("fill", x-55, y-80, 110, 160)
		end
		for i,card in ipairs(self.coins) do
			card:draw()
		end
	end

end

return collection