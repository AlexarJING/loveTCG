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
local img_back = love.graphics.newImage("res/assets/cardback.png")

function card:init(game,data,born,current)
	self.game = game
	self.born = game[born]
	self.current = current
	self:initProperty(data)
	self:initImage()
	self:initBack()
	self.tweens={}
	self.tweenStack = {}
end


function card:initProperty(data)
	for k,v in pairs(data) do
		self[k]=v
	end
	self.hp_max = self.hp
	self.shield_max = self.shield
	self.level = self.level or 1
	if self.level then
		self.price = self.basePrice and self.basePrice - self.level + 1
	end

	self.x = self.current.x or 0
	self.y = self.current.y or 0
	self.rz = self.current.rz or 0
	self.rx = self.current.rx or 0
	self.ry = self.current.ry or 0
	self.scale = self.current.scale or 0.5
	self.w = Width
	self.h = Height
	self.vduration=0
	self.offx=0
	self.offy=0
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
	self.img = love.graphics.newImage("res/cards/"..self.id..".png")
	self.tw = self.img:getWidth()
	self.th = self.img:getHeight()
	self.predraw  = love.graphics.newCanvas(Width,Height)
	love.graphics.setColor(255,255,255,255)
	love.graphics.setCanvas(self.predraw)
	--bg
	love.graphics.draw(self.img, 0, 0, 0, Width/self.tw,Height/self.th)
	--title
	love.graphics.setFont(self.game.font_title)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.printf(self.name, 3, 8, Width, "center")
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf(self.name, 0, 5, Width, "center")
	
	--description
	
	love.graphics.setFont(self.game.font_content)
	for i,text in ipairs(self.description) do
		love.graphics.setColor(0,0,0,255)
		love.graphics.printf(text, 3, (i-1)*20+textHeight/(#self.description+1)+ 180 + 3, Width, "center")
		love.graphics.setColor(255,255,255,255)
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
		love.graphics.setColor(0, 0, 255,255)
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


	--border
	if self.level == 1 then
		love.graphics.setColor(100, 255, 100, 200)
	elseif self.level == 2 then
		love.graphics.setColor(100, 100, 255, 200)
	elseif self.level == 3 then
		love.graphics.setColor(255, 100, 255, 200)
	else
		love.graphics.setColor(255, 255, 255, 200)
	end
	love.graphics.setLineWidth(10)
	love.graphics.rectangle("line", 0, 0, Width, Height)

	love.graphics.setCanvas()
end

local hw =Width/2
local hh =Height/2

function card:checkHover()
	if self.tweens.x or self.tweens.y then return end

	local dx,dy = self.game.mousex-self.x,self.game.mousey-self.y
	local rx,ry = math.axisRot(dx,dy,-self.rz)

	local mx,my = rx/self.scale/math.cos(self.ry),ry/self.scale/math.cos(self.rx)
	
	if mx>hw then return end
	if mx<-hw then return end
	if my>hh then return end
	if my<-hh then return end
	return true
end

function card:update(dt)
	self:vibrateUpdate(dt)
	--if self:needRedraw() then
		--self:updateCanvas()
	--end
	
	self:updateTweens(dt)

	if self:checkHover() then self.game.hoverCard = self end
end

function card:updateTweens(dt)
	for k,v in pairs(self.tweens) do
		if v:update(dt) then
			local tween = self.tweenStack[k] and self.tweenStack[k][1]
			if tween then
				self.tweens[k] = tween
				table.remove(self.tweenStack[k], 1)
			else
				self.tweens[k] = nil
			end
		end
	end
end

function card:addAnimate(duration , target , easing , delay, callback)
	for k,v in pairs(target) do
		local tween = Tween.new(duration, self, {[k]=v}, easing, delay)
		if self.tweens[k] then
			self.tweenStack[k] = self.tweenStack[k] or {}
			table.insert(self.tweenStack[k], tween)
		else
			self.tweens[k] = tween
		end
		
		tween.callback = function () 
			if callback then callback() end
		end
	end
end

function card:setAnimate(duration , target , easing , delay, callback)
	for k,v in pairs(target) do
		local tween = Tween.new(duration, self, {[k]=v}, easing, delay)
		self.tweens[k] = tween
		self.tweenStack[k] =  {}	
		tween.callback = function () 
			if callback then callback() end
		end
	end
end


function card:draw(color)
	love.graphics.setColor(255, 255, 255, 255)
	if color then love.graphics.setColor(color) end
	if math.cos(self.ry)<0 or math.cos(self.rx)<0 then
		love.graphics.draw(self.back, self.x+self.offx, self.y+self.offy, self.rz,
		 self.scale*math.cos(self.ry), -self.scale*math.cos(self.rx), Width/2, Height/2)
	else
		love.graphics.draw(self.predraw, self.x+self.offx, self.y+self.offy, self.rz,
		 self.scale*math.cos(self.ry), self.scale*math.cos(self.rx), Width/2, Height/2)
	end
	
end

function card:needRedraw()
	if self.hp == self.ohp and self.shield == self.oshield and self.last == self.olast then
		return false
	end

	self.ohp = self.hp
	self.shield = self.oshield
	self.last = self.olast
	return true
end


function card:updateCanvas()
	love.graphics.setCanvas(self.predraw)
	
	if self.hp then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.hp_max do
			love.graphics.draw(img_hp, 100 - self.hp_max*10 + (i-1)*17, 285)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.hp do
			love.graphics.draw(img_hp, 100 - self.hp_max*10 + (i-1)*17, 285)
		end
	end

	--shield
	if self.shield then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.shield_max do
			love.graphics.draw(img_shield,100 - self.shield_max*17 - (i-1)*17 , 285)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.shield do
			love.graphics.draw(img_shield,100 - self.shield_max*17 - (i-1)*17 , 285)
		end
	end


	--last 

	if self.last and type(self.last) == "number" then
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(self.game.font_content)
		love.graphics.draw(img_wait, 80, 283)
		love.graphics.printf("x"..tostring(self.last), 100, 283, Width, "left")
	end

	love.graphics.setCanvas()

end



function card:vibrate(duration, magnitude,vfunc)
    self.vduration, self.vMagnitude = duration or 0.3, magnitude or 5
    self.vfunc = vfunc
end


function card:vibrateUpdate(dt)
	if self.vduration<=0 then return end
	self.vduration = self.vduration -dt
	self.vMagnitude = self.vMagnitude*0.98
	self.offx = love.math.random(-self.vMagnitude, self.vMagnitude)
    self.offy = love.math.random(-self.vMagnitude, self.vMagnitude)
    if self.vduration<=0 then 
    	self.offx=0
    	self.offy=0
    	if self.vfunc then self.vfunc() end
    end
end

function card:standout()
	local y = self.y
	local ty = y>0 and y-50 or y+50
	self:addAnimate(0.3,{y=ty},"linear")
	self:addAnimate(0.3,{y=y},"linear")
end



return card