local shop = Class("shop")

local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"
local Bg = require "cls/bg"
local Button = require "cls/button"
local Info = require "cls/info"
local Progress = require "cls/progressbar"

local normal = love.graphics.newImage("res/assets/cardback.png")
local silver = love.graphics.newImage("res/assets/cardbacksilver.png")
local gold = love.graphics.newImage("res/assets/cardbackgold.png")
--350,512
local price = {
	{money="gold",amount = 100},
	{money="gold",amount = 1000},
	{money="gem",amount = 1},
}

local packs = {
	{x=-300,y=-50,img=normal,back="normal"},
	{x=0,y=-50,img=silver,back="silver"},
	{x=300,y=-50,img=gold,back="gold"},
}


function shop:init(parent)
	self.parent = parent
	self.bg = Bg("storeBg")
	self.bg.scale = 2
	self.font = love.graphics.newFont(30)
	self.info = Info(self)
	self.data = self.info.data
	
	self:reset()
end



function shop:reset()
	self.state = "buy"
	self.packs = table.copy(packs)
	self.showTag = {}
	self.ui = {}
	--(parent,x,y,w,h,text)
	self.buys = {
		Button(self,-300,150,120,50,"100 gold") ,
		Button(self,0,150,120,50,"1000 gold") ,
		Button(self,300,150,120,50,"1 gem") ,
	}
	
	for i = 1 , 3 do
		self.buys[i].onClick = function() 
			if self.data[price[i].money]<price[1].amount then return end
			self.data[price[i].money] = self.data[price[i].money] -price[i].amount
			self.state = "selected"
			self.selected = self.packs[i]
			self.ui ={}
			--Tween.new(duration, self, {[k]=v}, easing, delay)
			self.selected.tween = Tween.new(0.5,self.selected,{x=0,y=-50},"inQuad",0.3)
			self.selected.tween.callback = function()
				self.state = "show"
				self:getRandomCard(i)
			end
		end
	end
	local back = Button(self,500,300,100,50,"back")
	back.onClick = function()
		gamestate.switch(gameState.inter,gameState.builder_scene,nil,nil,self.data) 	
	end
	self.cards = {}
end


local rate = {}
rate[1] =  {["E"] = 0.001, [4]= 0.004,[3] = 0.01,[2] = 0.3,[1]=1}
rate[2] =  {["E"] = 0.004, [4]= 0.01,[3] = 0.3,[2] = 1,[1]=1}
rate[3] =  {["E"] = 0.01, [4]= 0.3,[3] = 1,[2] = 1,[1]=1}
function shop:getRandomCard(p)
	local cards= {}
	for i = 1, 3 do 
		local rarity 
		if love.math.random()< rate[p]["E"] then
			rarity = "E"
		elseif love.math.random()< rate[p][4] then
			rarity = 4
		elseif love.math.random()< rate[p][3] then
			rarity = 3
		elseif love.math.random()< rate[p][2] then
			rarity = 2
		elseif love.math.random()< rate[p][1] then
			rarity = 1
		end

		local dataSet = cardData.rarity[rarity]
		local data = dataSet[love.math.random(#dataSet)]
		data.back = self.packs[p].back
		cards[i] = Card(self,data,nil,{x=0+i*5,y=-50+i*5,rx=3.14,scale=0.8})
		cards[i]:vibrate(1)	
		local function callback()
			self:checkUpgrade(i)	
		end
		cards[i]:addAnimate(1,{x = (i-2)*300},"inQuad",2) --duration , target , easing , delay, callback
		cards[i]:addAnimate(1,{y=-50},"inQuad",2)
		cards[i]:addAnimate(1,{rx = 0},"inQuad",2,callback)
	end
	self.cards = cards
end

function shop:checkUpgrade(index)
	local card = self.cards[index]
	local data
	if card.isHero then
		data = self.data.collection.heros[card.faction][card.id]
	else
		data = self.data.collection.cards[card.faction][card.category][card.id]
	end
	if data then
		data.exp = data.exp + 1
		if data.exp>= 3^(data.level+1) then
			data.exp = 0
			data.level = data.level + 1
			self.showTag[index] = "upgrade"
		else
			table.insert(self.ui,Progress(self,(index-2)*300,100,150,20,3^(data.level+1),data.exp))
			self.showTag[index] = "exp"
		end
	else
		if card.isHero then
			self.data.collection.heros[card.faction][card.id] = {exp=0,level = 1,lib={}}
		else
			self.data.collection.cards[card.faction][card.category][card.id] = {exp=0,level = 1}
		end
		
		self.showTag[index] = "new"
	end

end

function shop:update(dt)
	self.mousex, self.mousey = self.parent.camera:mousepos() 
	for i,v in ipairs(self.ui) do
		v:update(dt)
	end

	if self.state == "buy" then

	elseif self.state == "selected" then
		self.selected.tween:update(dt)
	elseif self.state == "show" then
		for i,v in ipairs(self.cards) do
			v:update(dt)
		end
		if love.mouse.isDown(1) then
			self.state = "fadeout"
			for i = 1,3 do
				self.cards[i]:addAnimate(1,{alpha=0},"linear",1) 
			end
		end
	elseif self.state == "fadeout" then
		for i,v in ipairs(self.cards) do
			v:update(dt)
		end
		if self.cards[3].alpha == 0 then
			self:save()
		end
	end
end

function shop:save()
	self.info:saveUserFile()
	self:reset()
end


function shop:draw()
	
	self.bg:draw()
	self.info:draw()
	for i,v in ipairs(self.ui) do
		v:draw()
	end


	love.graphics.setColor(255, 255, 255, 255)


	if self.state == "buy" then
		for i,v in ipairs(self.packs) do
			for i = 1,3 do
				love.graphics.draw(v.img, v.x+i*5, v.y+i*5, 0, 0.5, 0.5, 175,256)
			end
		end
	elseif self.state == "selected" then
		local selected = self.selected
		for i = 1,3 do
			love.graphics.draw(selected.img, selected.x+i*5, selected.y+i*5,
			 0, 0.5, 0.5, 175,256)
		end
	elseif self.state == "show" then
		for i,v in ipairs(self.cards) do
			v:draw()
		end
		if self.showTag then
			for i,v in ipairs(self.showTag) do
				if v == "new" then
					love.graphics.setFont(self.font)
					love.graphics.printf("New!", (i-2)*300-50,80,100,"center")
				elseif v == "upgrade" then
					love.graphics.setFont(self.font)
					love.graphics.printf("upgrade!", (i-2)*300-50,80,100,"center")
				end
			end
		end
		love.graphics.setFont(self.font)
		love.graphics.printf("click to continue", -360, 200, 720, "center")
	elseif self.state == "fadeout" then
		for i,v in ipairs(self.cards) do
			v:draw()
		end
	end

end

return shop