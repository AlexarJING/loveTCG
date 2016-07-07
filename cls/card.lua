local card = Class("card")
local Width = 210
local Height = 312

local img_hp = love.graphics.newImage("res/others/hp.png")
local img_shield = love.graphics.newImage("res/others/shield.png")
local img_wait  = love.graphics.newImage("res/others/wait.png")
local rare_1 = love.graphics.newImage("res/others/rare-1.png")
local rare_2 = love.graphics.newImage("res/others/rare-2.png")
local rare_3 = love.graphics.newImage("res/others/rare-3.png")
local rare_4 = love.graphics.newImage("res/others/rare-4.png")
local rare_h = love.graphics.newImage("res/others/rare-hero.png")
local img_gold = love.graphics.newImage("res/others/gold.png")
local img_back = love.graphics.newImage("res/others/back.png")

function card:init(game,data,born)
	self.game = game
	self.born = born
	self:initProperty(data)
	self:initImage()
	self:initBack()
	self.tweens={}
end


function card:initProperty(data)
	for k,v in pairs(data) do
		self[k]=v
	end
	self.hp_max = self.hp
	self.shield_max = self.shield

	self.price = self.basePrice - self.level

	self.x = self.born.x or 0
	self.y = self.born.y or 0
	self.rz = self.born.rz or 0
	self.rx = self.born.rx or 0
	self.ry = self.born.ry or 0
	self.scale = 0.5
	self.w = Width
	self.h = Height
end

local textHeight = 150
function card:initBack()
	local tw = img_back:getWidth()
	local th = img_back:getHeight()
	self.back = love.graphics.newCanvas(Width,Height)
	love.graphics.setCanvas(self.back)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(img_back, 0, 0, 0, Width/tw,Height/th)
	love.graphics.setCanvas()
end


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
	--description
	love.graphics.setFont(self.game.font_content)
	for i,text in ipairs(self.description) do
		love.graphics.printf(text, 0, (i-1)*20+textHeight/(#self.description+1)+ 180, Width, "center")
	end
	--price
	if self.price then
		love.graphics.setColor(255, 255, 255,255)
		--love.graphics.circle("fill", 195, 20, 15)
		love.graphics.draw(img_gold, 180, 10,0,1.2,1.2)
		love.graphics.setFont(self.game.font_content)
		love.graphics.setColor(0, 0, 0,255)
		love.graphics.printf(self.price, 0, 11, Width-10, "right")
		love.graphics.setColor(0, 0, 0,255)
		love.graphics.printf(self.price, 0, 11, Width-9, "right")
		love.graphics.setColor(255, 255, 255,255)
		love.graphics.printf(self.price, 0, 11, Width-11, "right")
	end
	--rare
	if self.rare then
		love.graphics.setColor(255, 255, 255, 255)
		--love.graphics.circle("fill", 15, 160, 15)
		if self.rare == 1 then
			love.graphics.draw(rare_1, 5,150)
		elseif self.rare == 2 then
			love.graphics.draw(rare_2, 5,150)
		elseif self.rare == 3 then
			love.graphics.draw(rare_3, 5,150)
		elseif self.rare == 4 then
			love.graphics.draw(rare_4, 5,150)
		elseif self.rare == "hero" then
			love.graphics.draw(rare_h, 5,150)
		end
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
		love.graphics.printf("x"..tostring(self.last), 22, 283, Width, "left")
	end


	--border
	if self.race == "green" then
		love.graphics.setColor(100, 255, 100, 200)
	elseif self.race == "red" then
		love.graphics.setColor(255, 100, 100, 200)
	elseif self.race == "blue" then
		love.graphics.setColor(100, 100, 255, 200)
	elseif self.race == "purple" then
		love.graphics.setColor(255, 100, 255, 200)
	end
	love.graphics.setLineWidth(5)
	love.graphics.rectangle("line", 0, 0, Width, Height)

	love.graphics.setCanvas()
end

function card:checkHover()


end

function card:update(dt)
	for k,v in pairs(self.tweens) do
		v:update(dt)
	end
	if self:checkHover() then self.game.hoverCard = self end
end

function card:animate(time , target , easing)
	for k,v in pairs(target) do
		local tween = Tween.new(time, self, {[k]=v}, easing)
		self.tweens[k] = tween
		tween.callback = function () self.tweens[k] = nil end
	end

end

function card:draw()
	love.graphics.setColor(255, 255, 255, 255)
	if math.cos(self.ry)<0 or math.cos(self.rx)<0 then
		love.graphics.draw(self.back, self.x, self.y, self.rz, self.scale*math.cos(self.ry), self.scale*math.cos(self.rx), Width/2, Height/2)
	else
		love.graphics.draw(self.predraw, self.x, self.y, self.rz, self.scale*math.cos(self.ry), self.scale*math.cos(self.rx), Width/2, Height/2)
	end
	
end


return card