local cursor = Class("cursor")
local normal_img  = love.graphics.newImage("res/others/cursor.png")
local hover_img = love.graphics.newImage("res/others/cursor_hover.png")

function cursor:init(parent)
	self.parent = parent
	self.x=0
	self.y=0
	self.debug = false
	love.mouse.setVisible(false)
end

function cursor:update(hover)
	self.x = self.parent.mousex
	self.y = self.parent.mousey
	self.hover = hover
	self.down = love.mouse.isDown(1) or love.mouse.isDown(2)
end


function cursor:draw()
	love.graphics.setColor(255, 255, 255, 255)
	
	if self.hover then
		if not self.down then
			love.graphics.draw(hover_img, self.x,self.y)
		else
			love.graphics.draw(hover_img, self.x+3,self.y+3)
		end
	else
		if not self.down then
			love.graphics.draw(normal_img, self.x,self.y)
		else
			love.graphics.draw(normal_img, self.x+3,self.y+3)
		end
	end

	if self.debug and type(self.hover)== "table" then
		love.graphics.print(tostring(self.hover.current))
	end
	self.hover = nil
end

return cursor