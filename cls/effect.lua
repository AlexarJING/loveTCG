local effect = Class("effect")
local img={}
img.food = love.graphics.newImage("res/others/food.png")
img.gold = love.graphics.newImage("res/others/money.png")
img.skull = love.graphics.newImage("res/others/skull.png")
img.magic = love.graphics.newImage("res/others/magic.png")
img.attack = love.graphics.newParticleSystem(love.graphics.newImage("res/others/skull.png"), 64)
local p = img.attack
p:setParticleLifetime(0.1, 1) 
p:setEmissionRate(32)
p:setSizeVariation(1)
p:setSizes(1,0.5)
p:setLinearAcceleration(-200, -200, 200, 200)
p:setColors(255, 255, 255, 255, 255, 255, 255, 0) 

img.shield = love.graphics.newParticleSystem(love.graphics.newImage("res/assets/shield.png"), 64)
local p = img.shield
p:setParticleLifetime(1, 2) 
p:setEmissionRate(10)
p:setSizeVariation(1)
p:setSizes(1,1.3)
p:setColors(255, 255, 0, 200, 255, 255, 0, 0) 

function effect:init(tag,from,to,fading,during,easing,manual)
	if not manual then
		table.insert(game.effects, self)
	end
	self.tag = tag
	self.img = img[tag]
	self.x = from.x
	self.y = from.y
	self.alpha = 255
	self.tween = Tween.new(during, self, {x=to.x,y=to.y,alpha = fading and 0 or 255}, easing or "inBack")
	self.shadow = {}
	self.callbacks = {}
	self.tween.callback = function() 
		table.removeItem(game.effects,self)
		for i,v in ipairs(self.callbacks) do
			v()
		end
	end
	self.shadowCount = 5
	for i = 1, self.shadowCount do
		self.shadow[i]={x=self.x,y=self.y}
	end
end

function effect:setCallback(func)
	self.callbacks={func}
end

function effect:addCallback(func)
	table.insert(self.callbacks, func)
end

function effect:update(dt)
	self.tween:update(dt)
	
	if self.tag =="attack" or self.tag == "shield" then 
		self.img:update(dt) 
	else
		self.shadow[1].x = self.x ; self.shadow[1].y = self.y
		for i= self.shadowCount,2,-1 do
			self.shadow[i].x = self.shadow[i-1].x
			self.shadow[i].y = self.shadow[i-1].y
		end
	end
end


function effect:draw()
	if self.tag =="attack" or self.tag == "shield" then 
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(self.img,self.x,self.y)
	else
		for i,v in ipairs(self.shadow) do
			love.graphics.setColor(255, 255, 255, self.alpha/i)
			love.graphics.draw(self.img, v.x,v.y)
		end
	end
	
	
end

return effect