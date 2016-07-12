local button=Class("button")

function button:init(parent,x,y,w,h,text)
	self.parent = parent
	self.x=x
	self.y=y
	self.w=w
	self.h=h
	self.font = love.graphics.newFont(math.ceil(self.h*0.4))
	self.text=text
	self.color={100,200,255,255}
	table.insert(self.parent.buttons, self)
end

function button:check(x,y)
	if x< self.x or x>self.x+self.w then return false end
	if y< self.y or y>self.y+self.h then return false end
	return true
end

function button:update()
	self.hover=self:check(self.parent.mousex,self.parent.mousey)
	if self.hover and love.mouse.isDown(1) then
		if self.onDown then self.onDown(self) end
		self.down=true
	elseif self.hover and not love.mouse.isDown(1) and self.down then
		if self.onClick then self.onClick(self) end
		self.down=false
	end

end

function button:draw()
	local r,g,b,a=unpack(self.color)
	if not self.hover then a=a*3/4 end
	local offx,offy=0,0
	if self.down then offx=3;offy=3 end
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("line", self.x+offx, self.y+offy, self.w, self.h,self.w/4,self.h/4)
	love.graphics.setColor(r,g,b,a/2)
	love.graphics.rectangle("fill", self.x+offx, self.y+offy, self.w, self.h,self.w/4,self.h/4)
	love.graphics.setColor(255-r, 255-g, 255-g, 255)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x+offx, self.y+offy+self.h/4, self.w, "center")
end

return button