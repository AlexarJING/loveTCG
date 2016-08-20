local turn = Class("turn")


function turn:init(game,side)
	self.ry = 0
	self.d = 20
	self.turntime = 60
	self.timer = self.turntime
	self.game = game
	self.img = love.graphics.newImage("res/assets/coin.png")
	self.tw,self.th = self.img:getWidth(),self.img:getHeight()
	self.freez = false
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
	if not self.freeze then 
		self.timer = self.timer - dt
	end
	self.x = self.orientation*(320 - (self.timer/self.turntime)*640)
	self.ry = self.ry + 0.3
	if self.timer <0 then
		self.timer = self.turntime
		self.orientation = - self.orientation
		self.game:turnEnd()
	end
	return self:checkMouse()
end

function turn:checkHover()
	local x , y = self.game.mousex , self.game.mousey

	if x > self.x - self.d and x < self.x + self.d and
		y > self.y - self.d and y < self.y + self.d then
		return true
	end
end

function turn:checkMouse()
	self.hover = self:checkHover()

	if self.hover and self.game.click and 
		not (self.game.my ~= self.game.userside and self.game.gametype ~= "hotseat") then
		self.game:turnEnd()
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