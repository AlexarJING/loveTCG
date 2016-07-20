local result = Class("result")
local Bg = require "cls/bg"
local font = love.graphics.newFont(30)
local Frag = require "lib/frag"
local cardData = require "cls/cardDataLoader"
local Card = require "cls/card"
local Fire = require "lib/firework"
local Info = require "cls/info"

function result:init(parent,screenshot,hero,result,game)
	self.info = Info(self)
	self.game = game
	self.result = result
	self.bg = Bg("stoneBg")
	self.parent = parent
	self.screenshot = screenshot
	self.cards = {}
	self.fireworks={}
	self.hero = hero
	self.hero:addAnimate(1,{x=0},"inQuad",nil)
	self.hero:addAnimate(1,{y=0},"inQuad",nil)
	if result == "win" then
		self.hero:addAnimate(1,{scale=1},"inQuad",nil,
			function() 
				for i= 1,3 do
					table.insert(self.fireworks,self:fire())
				end
				self.showResult=true
			end)
	else
		self.hero:addAnimate(1,{scale=1},"inQuad",nil,function() self:breakout() end)
	end
	 --addAnimate(duration , target , easing , delay, callback)
	self:initBg()	
end

function result:initBg()
	self.bgCanvas = love.graphics.newCanvas(1280,720)
	love.graphics.setCanvas(self.bgCanvas)
	love.graphics.setColor(255, 255, 255, 50)
	for x = -10,10 ,2 do
		for y = -10,10,2 do
			love.graphics.draw(self.screenshot, x,y)
		end
	end
	love.graphics.setCanvas()
end

local colors={
	{255,255,100},
	{100,255,100},
	{100,100,255},
	{255,1000,255},
	{100,255,255},
	{255,100,100},
}


function result:fire()
	self.ready = true
	return Fire(
		300*(0.5-love.math.random()),
		400,
		love.math.random(),
		-13+6*love.math.random(),
		1+2*love.math.random(),nil,
		colors[love.math.random(6)]
		--{100+155*love.math.random(),100+155*love.math.random(),100+155*love.math.random()}
		)
end


function result:breakout()
	local cb = function()
		self.frag = Frag(self.hero.x,self.hero.y,0,self.hero.predraw) 
		self.hero = nil
		self.parent.camera:shake()
		self.showResult = true
	end
	self.hero:vibrate(nil,nil,cb)
	self.ready = true
end


function result:update(dt)
	self.mousex,self.mousey = self.parent.camera:mousepos()
	if self.hero then self.hero:update(dt) end
	if self.frag then self.frag:update(dt) end
	
	for i,v in ipairs(self.fireworks) do
		if v:update(dt) then
			self.fireworks[i]=self:fire()
		end
	end

	if self.ready and love.mouse.isDown(1) then
		self:toMenu()
	end
end

function result:toMenu()
	self:save()
	gamestate.switch(gameState.inter,gameState.builder_scene,nil,nil)
end

function result:save()
	local data = self.info:readUserFile()
	local hero = data.currentHero.id
	local faction = data.currentHero.faction
	local heroData = data.heros[faction][id]
	if self.result =="win" then
		data.gold = data.gold + 100*(2^self.game.aiLevel)
		heroData.exp = heroData.exp + 200
	else
		data.gold = data.gold + 50
		heroData.exp = heroData.exp + 50
	end
	self.info:saveUserFile()
end


function result:draw()
	self.bg:draw()
	

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.bgCanvas, 0,0,0,1,1,640,360)

	if self.hero then self.hero:draw() end
	if self.frag then self.frag:draw() end

	love.graphics.setColor(255, 255, 255, 255)
	if self.showResult then
		if self.result == "lose" then
			love.graphics.printf("YOU LOSE !\n+50 gold\n+50 exp", -360,100, 360, "center", 0, 2, 2)
		else
			love.graphics.printf("YOU WIN !\n+"..tostring(100*(2^self.game.aiLevel)).." gold\n+200 exp",
			 -360,180, 360, "center", 0, 2, 2)
		end
	end
	for i,v in ipairs(self.fireworks) do
		v:draw()
	end
end

return result