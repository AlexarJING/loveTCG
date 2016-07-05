local card = Class("card")
local Width = 210
local Height = 312



function card:init(game,data)
	self.game = game
	self:initProperty(data)
	self:initImage()
end


function card:initProperty(data)
	for k,v in pairs(data) do
		self[k]=v
	end

	self.hp = self.baseHp
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
		love.graphics.printf(text, 0, (i-1)*20+textHeight/(#self.discription+1)+ 200, Width, "center")
	end
	--price
	if self.price then
		love.graphics.setColor(255, 255, 0, 100)
		love.graphics.circle("fill", 195, 20, 15)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.printf(self.price, 0, 10, Width-8, "right")
	end

	if self.rare then
		love.graphics.setColor(255, 0, 255, 100)
		love.graphics.circle("fill", 20, 160, 15)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.printf(self.rare, 15, 150, Width, "left")
	end

	love.graphics.setCanvas()
end

function card:update(dt)

end

function card:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.predraw, self.x, self.y, self.r, self.sx, self.sy, Width/2, Height/2)
end


return card