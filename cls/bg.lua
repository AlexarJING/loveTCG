local bg = Class("bg")

function bg:init(name)
	name = name or "default"
	self.img  = love.graphics.newImage("res/bg/"..name..".png")
	self.tw = self.img:getWidth()
	self.th = self.img:getHeight()
	self.x = 0
	self.y = 0
	self.size = 2
	self.rot = 0
end

function bg:update(dt)

end

function bg:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rot , self.size, self.size, self.tw/2,self.th/2)
end

return bg