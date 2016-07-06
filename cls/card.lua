local card = Class("card")
local Width = 210
local Height = 312

local img_hp = love.graphics.newImage("res/others/hp.png")
local img_shield = love.graphics.newImage("res/others/shield.png")
local img_wait  = love.graphics.newImage("res/others/wait.png")

function card:init(game,data)
	self.game = game
	self:initProperty(data)
	self:initImage()
end


function card:initProperty(data)
	for k,v in pairs(data) do
		self[k]=v
	end
	self.hp_max = self.hp
	self.shield_max = self.shield

	self.price = self.basePrice - self.level

	self.x = 0
	self.y = 0
	self.r = 0
	self.sx = 1
	self.sy = 1
end

local textHeight = 150

function card:initImage()
	self.img = love.graphics.newImage("res/"..self.race.."/"..self.name..".png")
	self.tw = self.img:getWidth()
	self.th = self.img:getHeight()
	self.predraw  = love.graphics.newCanvas(Width,Height)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setCanvas(self.predraw)
	--bg
	love.graphics.draw(self.img, 0, 0, 0, Width/self.tw,Height/self.th)
	--title
	love.graphics.setFont(self.game.font_title)
	love.graphics.printf(self.name, 0, 40, Width, "center")
	--discription
	love.graphics.setFont(self.game.font_content)
	for i,text in ipairs(self.discription) do
		love.graphics.printf(text, 0, (i-1)*20+textHeight/(#self.discription+1)+ 180, Width, "center")
	end
	--price
	if self.price then
		love.graphics.setColor(255, 255, 0, 100)
		love.graphics.circle("fill", 195, 20, 15)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.printf(self.price, 0, 10, Width-8, "right")
	end
	--rare
	if self.rare then
		love.graphics.setColor(255, 0, 255, 100)
		love.graphics.circle("fill", 15, 160, 15)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.printf(self.rare, 10, 150, Width, "left")
	end

	--life

	if self.hp then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.hp_max do
			--love.graphics.circle("fill", 220 - i*20, 300, 10)
			love.graphics.draw(img_hp, 220 - self.hp_max*20 + (i-1)*17, 290)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.hp do
			--love.graphics.circle("fill", 220 - self.hp_max*20 + (i-1)*20, 300, 8)
			love.graphics.draw(img_hp, 220 - self.hp_max*20 + (i-1)*17, 290)
		end
	end

	--shield
	if self.shield then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.shield_max do
			--love.graphics.circle("fill", 220 - self.hp_max*17 - i*17 , 290, 10)
			love.graphics.draw(img_shield,220 - self.hp_max*17 - (i+1)*17 , 287)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.shield do
			--love.graphics.circle("fill", 220 - self.hp_max*17 -self.shield_max*17 + (i-1)*20, 290, 8)
			love.graphics.draw(img_shield,220 - self.hp_max*17 - (i+1)*17 , 287)
		end
	end


	--last 

	if self.last then
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.draw(img_wait, 5, 283)
		love.graphics.printf(self.last, 22, 283, Width, "left")
	end


	--border
	love.graphics.setColor(255, 0, 0, 200)
	love.graphics.rectangle("line", 0, 0, Width, Height)

	love.graphics.setCanvas()
end

function card:update(dt)

end

function card:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.predraw, self.x, self.y, self.r, self.sx, self.sy, Width/2, Height/2)
end


return card