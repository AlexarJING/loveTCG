local effect = Class("effect")
local img={}
img.food = love.graphics.newImage("res/others/food.png")
img.gold = love.graphics.newImage("res/others/money.png")
img.skull = love.graphics.newImage("res/others/skull.png")
img.magic = love.graphics.newImage("res/others/magic.png")
img.attack = love.graphics.newImage("res/others/skull.png")
img.shield = love.graphics.newImage("res/assets/shield.png")



function effect:init(parent,tag,from,to,fading,during,easing,manual)
	self.parent = parent
	if not manual then
		table.insert(parent.effects, self)
	end
	self.tag = tag
	self.img = img[tag]
	self.w = self.img:getWidth()
	self.h = self.img:getHeight()
	self.x = from.x
	self.y = from.y

	self.mx =  (love.math.random()-0.5)*30 + self.x / 2 
	self.my = (love.math.random()-0.5)*30 + self.y / 2
	self.alpha = 255

	self.shadow = {}
	self.callbacks = {}
	
	self.shadowCount = 5
	for i = 1, self.shadowCount do
		self.shadow[i]={x=self.x,y=self.y}
	end
	
	self.tween = Tween.new(during/2, self, {x=self.mx,y=self.my}, easing or "inBack")
	self.tween.callback = function()
		self.tween = Tween.new(during/2, self, {x=to.x,y=to.y,alpha = fading and 0 or 255}, easing or "inBack")
		self.tween.callback = function() 
			table.removeItem(parent.effects,self)
			for i,v in ipairs(self.callbacks) do
				v()
			end
		end
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

	self.shadow[1].x = self.x ; self.shadow[1].y = self.y
	for i= self.shadowCount,2,-1 do
		self.shadow[i].x = self.shadow[i-1].x
		self.shadow[i].y = self.shadow[i-1].y
	end
end


function effect:draw()

	for i,v in ipairs(self.shadow) do
		love.graphics.setColor(255, 255, 255, self.alpha/i)
		love.graphics.draw(self.img, v.x,v.y,0,1,1,self.w/2,self.h/2)
	end
	
end

return effect