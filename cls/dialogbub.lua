local dialog = Class("dialog")

local offleft = 50
local offright = 50
local offheight = 130
local quotheight = 30

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
	if love.keyboard.isDown("space") then self.readCD=-1 end
	if self.readCD<0 then
		self.readCD = self.readSpeed
		if self.readPos<#self.content then
			self.readPos = self.readPos + 1
			self.read = self.read .. self.content[self.readPos]
		else
			self.done= true
		end
	end

end

function dialog:draw()
	love.graphics.setFont(self.font)
	if self.up then
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.rectangle("fill", self.x + offleft - self.width - 40, self.y + offheight - self.height*2, self.width + 40, self.height*2)
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.rectangle("line", self.x + offleft -self.width - 40, self.y + offheight - self.height*2, self.width + 40, self.height*2)
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.polygon("fill", 
			self.x, self.y+offheight-self.height*2 + 2,
			self.x ,self.y+offheight-self.height*2 -quotheight +2 ,
			self.x-offright, self.y+offheight-self.height*2 + 2)
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.line(
			self.x, self.y+offheight-self.height*2 + 2,
			self.x ,self.y+offheight-self.height*2 -quotheight +2 ,
			self.x-offright, self.y+offheight-self.height*2 + 2)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf(self.read, self.x -self.width - 40 + offleft + 20 , self.y  - self.height*2 + offheight + self.height/2,self.width + 40,"left")
	else
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.rectangle("fill", self.x - offleft, self.y - offheight, self.width + 40, self.height*2)
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.rectangle("line", self.x - offleft, self.y - offheight, self.width + 40, self.height*2)
		love.graphics.setColor(50, 50, 50, 255)
		love.graphics.polygon("fill", 
			self.x, self.y-offheight+self.height*2 - 2,
			self.x ,self.y-offheight+self.height*2 +quotheight -2 ,
			self.x+offright, self.y-offheight+self.height*2 - 2)
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.line(
			self.x, self.y-offheight+self.height*2,
			self.x ,self.y-offheight+self.height*2+quotheight,
			self.x+offright, self.y-offheight+self.height*2)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.printf(self.read, self.x -offleft + 20 , self.y - offheight + self.height/2,self.width + 40,"left")
	end
end

return dialog