local ind = Class("indicator")


function ind:init(parent,x,y,w,h)
	self.parent = parent
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.off = 0
	table.insert(self.parent.ui, self)
end

function ind:update(dt)
	self.off = self.off - dt*30
	if self.off<0 then
		self.off = 20
	end
end

function ind:draw()
	love.graphics.setColor(255, 100, 100, 255)
	love.graphics.setLineWidth(3)
	love.graphics.rectangle("line", self.x - self.w/2 - self.off/2, self.y - self.h/2 - self.off/2,
		self.w +self.off, self.h + self.off)
	love.graphics.setLineWidth(1)
end


return ind