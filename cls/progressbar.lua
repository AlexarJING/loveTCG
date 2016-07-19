local progress=Class("progress")

function progress:init(parent,x,y,w,h,maxValue,currentValue)
	self.parent = parent
	self.x=x
	self.y=y
	self.w=w
	self.h=h
	self.font = love.graphics.newFont(math.ceil(self.h*0.4))
	self.text=text
	self.color={100,200,255,255}
	self.enable = true
	self.visible = true
	self.showNumber = true
	self.lagging = 0.1
	self.maxValue = maxValue
	self.currentValue = currentValue
	self.targetValue = currentValue
	table.insert(self.parent.ui, self)
end

function progress:update(dt)
	if not self.visible then return end
	if self.targetValue > self.currentValue then
		self.currentValue = self.currentValue + self.lagging*dt
	else
		self.currentValue = self.currentValue - self.lagging*dt
	end
end



function progress:draw()
	if not self.visible then return end
	love.graphics.setLineWidth(1)
	local r,g,b,a=unpack(self.color)
	
	
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("line", self.x - self.w/2, self.y -self.h/2, self.w, self.h,self.w/8,self.h/8)
	love.graphics.setColor(r,g,b,a/2)
	love.graphics.rectangle("fill", self.x -self.w/2, self.y - self.h/2, self.w, self.h,self.w/8,self.h/8)
	
	
	love.graphics.setColor(255-r, 255-g, 255-g, 255)
	love.graphics.rectangle("fill", self.x-self.w*0.49, self.y-self.h*0.4, 
		self.w*0.98*self.currentValue/self.maxValue, self.h*0.8)
	love.graphics.setColor(0,0,0,255)
	if self.showNumber then
		love.graphics.setFont(self.font)
		local text = string.format("%d/%d",self.currentValue,self.maxValue)
		love.graphics.printf(text, self.x -self.w/2, self.y+self.h/4 - self.h/2, self.w, "center")
	end
end

return progress