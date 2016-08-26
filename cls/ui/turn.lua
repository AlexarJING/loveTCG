local turn = Class("turn")


function turn:init(parent,side)
	self.ry = 0
	self.d = 20
	self.turntime = 60
	self.timer = self.turntime
	self.parent = parent
	self.img = love.graphics.newImage("res/assets/coin.png")
	self.tw,self.th = self.img:getWidth(),self.img:getHeight()
	self.freez = false
	table.insert(parent.ui,self)
end

function turn:setTurn(side)
	if side == "up" then
		self.x = 320
		self.y = 0
		self.orientation = -1
	else
		self.x = -320
		self.y = 0
		self.orientation = 1
	end
end

function turn:update(dt)
	if not self.parent.lockTime then 
		self.timer = self.timer - dt
	end
	self.x = self.orientation*(320 - (self.timer/self.turntime)*640)
	self.ry = self.ry + 0.3
	if self.timer <0 then
		self.timer = self.turntime
		self.orientation = - self.orientation
		self.parent:turnEnd()
	end

	self:checkMouse()

	if self.hover  then
		self.parent.hoverUI = self
	end
end

function turn:checkHover()
	local x , y = self.parent.mousex , self.parent.mousey

	if x > self.x - self.d and x < self.x + self.d and
		y > self.y - self.d and y < self.y + self.d then
		return true
	end
end

function turn:checkMouse()
	self.hover = self:checkHover()

	if self.hover and self.parent.click and 
		not (self.parent.my ~= self.parent.userside and self.parent.gametype ~= "hotseat") then
		self.parent:turnEnd()
	end

	return self.hover
end

function turn:endTurn()
	self.timer = self.turntime
	self.orientation = - self.orientation
end

function turn:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.img, self.x, self.y, 0, math.cos(self.ry), 1, self.tw/2,self.th/2)
end

return turn