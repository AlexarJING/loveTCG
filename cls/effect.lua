local effect = Class("effect")
local img={}
img.food = love.graphics.newImage("res/others/food.png")
img.gold = love.graphics.newImage("res/others/money.png")
img.skull = love.graphics.newImage("res/others/skull.png")
img.magic = love.graphics.newImage("res/others/magic.png")


function effect:init(tag,from,to,fading,during,easing)
	table.insert(game.effects, self)
	self.img = img[tag]
	self.x = from.x
	self.y = from.y
	self.alpha = 255
	self.tween = Tween.new(during, self, {x=to.x,y=to.y,alpha = fading and 0 or 255}, easing or "inBack")
	self.tween.callback = function() table.removeItem(game.effects,self)end
end


function effect:update(dt)
	self.tween:update(dt)
end


function effect:draw()
	love.graphics.setColor(255, 255, 255, self.alpha)
	love.graphics.draw(self.img, self.x,self.y)
end

return effect