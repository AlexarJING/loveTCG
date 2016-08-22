local dialog = Class("dialog")

function dialog:init(x,y,str,up)
	self.str = str
	self.content = string.toTable(str)
	self.font = love.graphics.newFont("res/others/chinesefont.ttf", 22)
	self.width = self.font:getWidth(str)
	self.height = self.font:getHeight(str)
	self.readSpeed = 0.1
	self.readCD = 0
	self.read = ""
	self.readPos = 0
	self.x = x
	self.y = y
	self.up = up
end

function dialog:update(dt)
	self.readCD = self.readCD - dt
	if self.readCD<0 then
		self.readCD = self.readSpeed
		if self.readPos<#self.content then
			self.readPos = self.readPos + 1
			self.read = self.read .. self.content[self.readPos]
		end
	end

end

function dialog:draw()
	love.graphics.setFont(self.font)
	if self.up then


	else
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.rectangle("line", self.x - 70 , self.y-200, self.width+40, self.height+50)
		love.graphics.line(self.x - 32 , self.y - self.height -140 , 
			self.x , self.y - self.height -50  , self.x + 82,self.y - self.height -140 )
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.rectangle("fill", self.x - 70 , self.y-200, self.width+40, self.height+50)
		love.graphics.polygon("fill", self.x - 30 , self.y - self.height -140 , 
			self.x , self.y - self.height -50  , self.x + 80,self.y - self.height -140 )
		

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print(self.read, self.x -50 , self.y - 150 - self.height)
	end
end

return dialog