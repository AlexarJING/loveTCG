local button=Class("button")

function button:init(parent,x,y,w,h,text,cb)
	self.parent = parent
	self.x=x
	self.y=y
	self.w=w
	self.h=h
	self.font = love.graphics.newFont(math.ceil(self.h*0.4))
	self.text=text
	self.color={100,200,255,255}
	self.enable = true
	self.onClick = cb
	self.visible = true
	table.insert(self.parent.ui, self)
end

function button:check(x,y)
	if x< self.x-self.w/2 or x>self.x+self.w/2 then return false end
	if y< self.y-self.h/2 or y>self.y+self.h/2 then return false end
	return true
end

function button:update()
	if not self.visible then return end
	self.hover=self:check(self.parent.mousex,self.parent.mousey)
	if self.hover and love.mouse.isDown(1) then
		if self.onDown then self.onDown(self) end
		self.down=true
	elseif self.hover and not love.mouse.isDown(1) and self.down then
		if self.onClick  and self.enable then self.onClick(self) end
		self.down=false
	end

end

function button:draw()
	if not self.visible then return end
	love.graphics.setLineWidth(2)
	local r,g,b,a=unpack(self.color)
	if not self.enable then
		r,g,b = 150,150,150
	end
	if not self.hover then a=a*3/4 end
	local offx,offy=0,0
	if self.down then offx=3;offy=3 end
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("line", self.x+offx - self.w/2, self.y+offy -self.h/2, self.w, self.h,self.w/4,self.h/4)
	love.graphics.setColor(r,g,b,a/2)
	love.graphics.rectangle("fill", self.x+offx -self.w/2, self.y+offy - self.h/2, self.w, self.h,self.w/4,self.h/4)
	love.graphics.setColor(255-r, 255-g, 255-g, 255)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.text, self.x+offx -self.w/2, self.y+offy+self.h/4 - self.h/2, self.w, "center")
end

return button