local menu = Class("menu")
local Button = require "cls/button"
local Bg = require "cls/bg"
local cardData = require "cls/cardDataLoader"



local function getAI(playerdata)

	range = playerdata
	local foelevel
	local rnd = love.math.random()
	if rnd<range/100 then
		foelevel = 5
	elseif rnd<range /90 then
		foelevel = 4
	elseif rnd<range /80 then
		foelevel = 3
	elseif rnd<range /50 then
		foelevel = 2
	else
		foelevel = 1
	end



	local foe = table.random(deckData)
	
	for i,v in ipairs(foe.lib) do
		local rnd = love.math.random()
		if rnd< foelevel/5 then
		
		elseif rnd< foelevel/4 then
			v.level = v.level -1
		else
			v.level = v.level - 2
		end
		if v.level<1 then v.level = 1 end
	end

	foe.deck = {}

	local allCoins = {}
	for k,v in pairs(cardData.coins) do
		table.insert(allCoins,k)
	end

	for i = 1, 10 do
		if love.math.random()<(0.2*foelevel)^2 then
			table.insert(foe.deck, table.random(allCoins))
		end
	end
	foe.level = foelevel
	foe.type = "ai"
	return foe
end

local function getNetplayer(playerdata)
	local foedata
	loader.addPack(self,function()
		playerdata.id = love.connectionID
		love.client:emit("search",playerdata)
		while true do
			foedata = client.foedata
			if foedata then break end
			if love.keyboard.isDown("escape") then break end
			coroutine.yield()
		end
	end,"lib/loading","searching")
	foedata.type = "net"
	return foedata
end


function menu:init(parent)
	self.parent = parent
	self.bg = Bg("title",0,0,2)
	self.bg.color = {0,0,0,255}
	self.ui = {}
	self.x = 500
	self.y = 10

	local journey = Button(self,self.x,-300,250,50,"journey")
	local skirmish = Button(self,self.x,-200,250,50,"skirmish")
	skirmish.onClick = function()
		local playerdata = self.parent.playerdata
		if not playerdata then return end
		local foedata = getAI(playerdata)
		gamestate.switch(gameState.game_scene,playerdata,foedata)
	end
	local melee = Button(self,self.x,-100 + self.y,250,50,"melee")
	local arena = Button(self,self.x,0+ self.y, 250,50,"arena")
	arena.onClick = function()
		local playerdata = self.parent.playerdata
		if not playerdata then return end
		local foedata = getNetPlayer(playerdata)
		if not foedata then return end
		gamestate.switch(gameState.game_scene,playerdata,foedata)
	end
	local shop = Button(self,self.x, 100+ self.y,250,50,"shop")
	shop.onClick = function()
		gamestate.switch(gameState.inter,gameState.shop_scene)
	end
	local editor = Button(self,self.x,200+ self.y,250,50,"editor")
	editor.onClick = function()
		self.parent:initEditor()
	end
	
	local exit = Button(self,self.x,300+ self.y,250,50,"exit")
	exit.onClick = function()
		love.event.quit()
	end
end


function menu:update(dt)
	self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	self.hoverUI= nil
	for i,btn in ipairs(self.ui) do
		btn:update(dt)
	end
	self.parent.hoverUI = self.parent.hoverUI or self.hoverUI
end


function menu:draw()
	self.bg:draw()
	for i,btn in ipairs(self.ui) do
		btn:draw()
	end

end




return menu