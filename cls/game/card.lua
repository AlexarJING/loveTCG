local card = Class("card")
local Width = 210
local Height = 312

local img_hp = love.graphics.newImage("res/others/hp.png")
local img_shield = love.graphics.newImage("res/others/shield.png")
local img_wait  = love.graphics.newImage("res/others/wait.png")
local img_charge = love.graphics.newImage("res/others/charge.png")
local rare_1 = love.graphics.newImage("res/others/rare-1.png")
local rare_2 = love.graphics.newImage("res/others/rare-2.png")
local rare_3 = love.graphics.newImage("res/others/rare-3.png")
local rare_4 = love.graphics.newImage("res/others/rare-4.png")
local rare_h = love.graphics.newImage("res/others/rare-hero.png")
local rare_e = love.graphics.newImage("res/others/RarityGem5.png")
local img_gold = love.graphics.newImage("res/others/gold.png")
local img_back = {
	normal = love.graphics.newImage("res/assets/cardback.png"),
	silver = love.graphics.newImage("res/assets/cardbacksilver.png"),
	gold = love.graphics.newImage("res/assets/cardbackgold.png"),
}

local img_frame = {
	love.graphics.newImage("res/assets/cardframe-normal.png"),
	love.graphics.newImage("res/assets/cardframe-silver.png"),
	love.graphics.newImage("res/assets/cardframe-gold.png"),
}


local cardImage = {}
local language = "cn"
local font_title = 
	language == "cn" and  
	love.graphics.newFont("res/others/chinesefont.ttf", 22) or
	love.graphics.newFont(22)
local font_content = language == "cn" and  
	love.graphics.newFont("res/others/chinesefont.ttf", 18) or
	love.graphics.newFont(18)
local font_number = love.graphics.newFont(18)

local backCanvas

function card:init(game,data,born,current,state)
	self.game = game
	self.born = game[born]
	self.current = current
	self:initProperty(data)
	self:initImage()
	self:updateCanvas()
	self:initBack()
	self.tweens={}
	self.tweenStack = {}
	if state then card:setState(state) end
	if loader.running then coroutine.yield() end
end

function card:getSide(who)
	who = who or "my"
	
	local my = self.current.parent
	local your = self.current.parent == self.game.up and 
		self.game.down or self.game.up
	if who == "my" then
		return my,your
	else 
		return your,my
	end
end

function card:placeInGame()
	local place = self.current.name
	local pos = table.getIndex(self.current.cards,self)
	--local side = self.current.parent
	local side = self.current.parent == game.my and "my" or "your"
	return side,place,pos
end


function card:setState(state)
	self.hp = state.hp
	self.last = state.last
	self.charge = state.charge
	self.timer = state.timer
	self:updateCanvas()
end



function card:reset()
	self.hp = self.data.hp
	self.last = self.data.last
	if self.chargeMin then
		self.charge = self.chargeMin
	else
		self.charge = self.data.chargeInit or self.data.charge
	end
	self.charging = self.data.charging
	self.awaken = self.data.awaken
	self.timer = self.data.timer
	self:updateCanvas()
end


function card:initProperty(data)
	table.copy(data,self)
	self.data = data
	self.hp = self.data.hp
	self.hp_max = self.isHero and 300 or self.data.hp
	self.last = self.data.last
	self.charge = self.data.chargeInit or self.data.charge
	self.charging = self.data.charging
	self.timer = self.data.timer

	if language == "cn" then
		self.name = data.name_cn or self.name
		self.description = data.description_cn or self.description
	end

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
	self.magnitude = 0
	self.alpha = 255
	self.cardback = self.back and img_back[self.back] or img_back.normal
end

local textHeight = 150
function card:initBack()
	local tw = self.cardback:getWidth()
	local th = self.cardback:getHeight()
	backCanvas = backCanvas or love.graphics.newCanvas(Width,Height)
	love.graphics.setCanvas(backCanvas)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.cardback, 0, 0, 0, Width/tw,Height/th)
	love.graphics.setCanvas()
end

local count = 0

function card:initImage()
	if not cardImage[self.id] then
		cardImage[self.id]= love.graphics.newImage("res/cards/"..self.img_name..".png")
		count = count+1
	end
		
	self.img = cardImage[self.id]

	self.tw = self.img:getWidth()
	self.th = self.img:getHeight()
	self.predraw  = love.graphics.newCanvas(Width,Height)

end




local hw =Width/2
local hh =Height/2

function card:checkHover()
	--if self.tweens.x or self.tweens.y then return end

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


	self:updateTweens(dt)
	
	if self:checkHover() then self.game.hoverCard = self end
	

end

function card:updateTweens(dt)
	local finish = true
	for k,v in pairs(self.tweens) do
		if v:update(dt) then
			local tween = self.tweenStack[k] and self.tweenStack[k][1]
			if tween then
				finish = false
				self.tweens[k] = tween
				table.remove(self.tweenStack[k], 1)
			else
				self.tweens[k] = nil
			end
		else
			finish = false
		end
	end
	self.stopMoving = finish
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
		if callback then tween.callback = callback end
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
	--[[
	if self.awaken == false then
		love.graphics.setColor(100, 100, 100, self.alpha)
	else
		love.graphics.setColor(255, 255, 255, self.alpha)	
	end]]
	
	love.graphics.setColor(255, 255, 255, self.alpha)
	if color then love.graphics.setColor(color) end

	local offx = 2*(love.math.random()-0.5)*self.magnitude
	local offy = 2*(love.math.random()-0.5)*self.magnitude

	if math.cos(self.ry)<0 or math.cos(self.rx)<0 then
		love.graphics.draw(backCanvas, self.x+offx, self.y+offy, self.rz,
		 self.scale*math.cos(self.ry), -self.scale*math.cos(self.rx), Width/2, Height/2)
	else
		love.graphics.draw(self.predraw, self.x+offx, self.y+offy, self.rz,
		 self.scale*math.cos(self.ry), self.scale*math.cos(self.rx), Width/2, Height/2)
	end
	
end



local mask_shader = love.graphics.newShader [[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).a == 0.0) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]


function card:updateCanvas()
	love.graphics.setColor(255,255,255,255)
	love.graphics.setCanvas(self.predraw)
	--bg
	local function myStencilFunction()
		love.graphics.setShader(mask_shader)
		love.graphics.draw(self.cardback, 0, 0, 0, Width/self.tw,Height/self.th)
		love.graphics.setShader()
	end
	love.graphics.stencil(myStencilFunction, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    love.graphics.draw(self.img, 0, 0, 0, Width/self.tw,Height/self.th)
    love.graphics.setStencilTest()


	
	--border
	if img_frame[self.level] then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(img_frame[self.level],0, 0, 0, Width/self.tw,Height/self.th)
	end


	--title
	love.graphics.setFont(font_title)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.printf(self.name, 3, 8, Width, "center")
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf(self.name, 0, 5, Width, "center")
	
	--description
	
	love.graphics.setFont(font_content)
	local str = ""
	for i,text in ipairs(self.description) do
		str = str .. text .. "\n"
	end
	love.graphics.setColor(0,0,0,255)
	love.graphics.printf(str, 3, 3-string.len(str)/5 + 250, Width, "center")
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf(str, 0, -string.len(str)/5 + 250 , Width, "center")

	--price
	if self.price then
		love.graphics.setColor(255, 255, 255,255)
		--love.graphics.circle("fill", 195, 20, 15)
		love.graphics.draw(img_gold, 177, 10,0,1.3,1.3)
		love.graphics.setFont(font_number)
		love.graphics.setColor(0, 0, 0,255)
		love.graphics.printf(self.price, 177, 11, 30, "center")
		love.graphics.setColor(0, 0, 0,255)
		love.graphics.printf(self.price, 176, 11, 30, "center")
		love.graphics.setColor(0, 0, 255,255)
		love.graphics.printf(self.price, 175, 11, 30, "center")
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
		elseif self.rare == "H" then
			love.graphics.draw(rare_h, 5,150)
		elseif self.rare =="E" then
			love.graphics.draw(rare_e, 5,150)
		end
	end


	
	--Width
	
	if self.hp and not self.isHero then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.hp_max do
			love.graphics.draw(img_hp, Width/2 - self.hp_max*10 + (i-1)*20, 285)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.hp do
			love.graphics.draw(img_hp, Width/2 - self.hp_max*10 + (i-1)*20, 285)
		end
	end

	--shield
	if (self.charge and self.intercept) or self.cancel then
		love.graphics.setColor(0, 0, 50, 200)
		love.graphics.rectangle("fill", 0, 50, 50, 22,5,5)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(font_content)
		love.graphics.draw(img_shield, 5, 50)
		love.graphics.printf("x"..tostring(self.charge or self.cancel), 25, 50, Width, "left")
	elseif self.charge then
		love.graphics.setColor(0, 0, 50, 200)
		love.graphics.rectangle("fill", 0, 50, 50, 22,5,5)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(font_content)
		love.graphics.draw(img_charge, 5, 50)
		love.graphics.printf("x"..tostring(self.charge), 25, 50, Width, "left")
	end


	--last 

	if self.last and type(self.last) == "number" then
		love.graphics.setColor(0, 0, 50, 200)
		love.graphics.rectangle("fill", 0, 50, 50, 22,5,5)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(font_content)
		love.graphics.draw(img_wait, 5, 50)
		love.graphics.printf("x"..tostring(self.last), 25, 50, Width, "left")
	end

	if self.timer then
		love.graphics.setColor(0, 0, 50, 200)
		love.graphics.rectangle("fill", 0, 50, 50, 22,5,5)
		love.graphics.setColor(255,255,255,255)
		love.graphics.setFont(font_content)
		love.graphics.draw(img_wait, 5, 50)
		love.graphics.printf("x"..tostring(self.timer), 25, 50, Width, "left")
	end	

	love.graphics.setCanvas()

end



function card:vibrate(duration, magnitude,func)
	self.magnitude = magnitude or 5
    self:setAnimate(duration or 0.5 ,{magnitude = 0},"outQuad",nil,func)
end


function card:standout()
	local tween = self.tweenStack.y and self.tweenStack.y[#self.tweenStack.y]
	local y
	if tween then 
		y = tween.target.y
	elseif self.tweens.y then
		y = self.tweens.y.target.y
	else
		y = self.y
	end 
	local ty = y>0 and y-50 or y+50

	self:setAnimate(0.3,{y=ty},"linear")
	self:addAnimate(0.3,{y=y},"linear")
end

function card:turnaround(func)
	self:setAnimate(0.3,{ry=3.14},"linear")
	self:addAnimate(0.3,{ry=0},"linear")
end

function card:cast(name,...)
	if self.ability[name] then
		return self.ability[name](self,self.game,...)
	end
end

return card