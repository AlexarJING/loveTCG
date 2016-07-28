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
local font_title = love.graphics.newFont(30)
local font_content = love.graphics.newFont(20)


function card:init(game,data,born,current,state)
	self.game = game
	self.born = game[born]
	self.current = current
	self.data = data
	self:initProperty(data)
	self:initImage()
	self:updateCanvas()
	self:initBack()
	self.tweens={}
	self.tweenStack = {}
	if state then card:setState(state) end
end

function card:setState(state)
	self.hp = state.hp
	self.last = state.last
	self.shield = state.shield
	self:updateCanvas()
end


function card:reset()
	self.hp = self.data.hp
	self.last = self.data.last
	self.shield = self.data.shield
	self:updateCanvas()
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
	self.alpha = 255
	self.cardback = self.back and img_back[self.back] or img_back.normal
end

local textHeight = 150
function card:initBack()
	local tw = self.cardback:getWidth()
	local th = self.cardback:getHeight()
	self.back = love.graphics.newCanvas(Width,Height)
	love.graphics.setCanvas(self.back)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.cardback, 0, 0, 0, Width/tw,Height/th)
	love.graphics.setCanvas()
end

local count = 0

function card:initImage()
	if not cardImage[self.id] then
		cardImage[self.id]= love.graphics.newImage("res/cards/"..self.id..".png")
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

	self:vibrateUpdate(dt)

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
	love.graphics.setColor(255, 255, 255, self.alpha)
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
		love.graphics.draw(img_gold, 177, 10,0,1.3,1.3)
		love.graphics.setFont(font_content)
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
		elseif self.rare == "hero" then
			love.graphics.draw(rare_h, 5,150)
		end
	end


	

	
	if self.hp then
		love.graphics.setColor(100, 100, 100, 255)
		for i =1 , self.hp_max do
			love.graphics.draw(img_hp, 118 - self.hp_max*17 + (i-1)*17, 285)
		end
		love.graphics.setColor(255,255,255,255)
		for i =1 , self.hp do
			love.graphics.draw(img_hp, 118 - self.hp_max*17 + (i-1)*17, 285)
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
		love.graphics.setFont(font_content)
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

function card:turnaround()
	self:setAnimate(0.3,{rx=3.14},"linear")
	self:addAnimate(0.3,{rx=0},"linear")
end

return card