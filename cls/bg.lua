local bg = Class("bg")

function bg:init(name,x,y,scale)
	name = name or "default"
	self.img  = love.graphics.newImage("res/assets/"..name..".png")
	self.tw = self.img:getWidth()
	self.th = self.img:getHeight()
	self.x = x or 0
	self.y = y or 0
	self.scale = scale or 1
	self.rot = 0
end

function bg:update(dt)

end

function bg:draw()
	if self.color then
		love.graphics.setColor(self.color)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	
	love.graphics.draw(self.img, self.x, self.y, self.rot , self.scale, self.scale, self.tw/2,self.th/2)
end

return bg