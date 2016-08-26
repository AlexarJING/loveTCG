local textInput=Class("text")
local utf8 = require("utf8")
local cnFont = love.graphics.newFont(35)

function textInput:init(parent,x,y,w,h,tag,text)
	self.parent = parent
	self.x=x
	self.y=y
	self.w=w
	self.h=h
	self.fontHeight = math.ceil(self.h*0.4)
	self.font = cnFont--love.graphics.newFont(self.fontHeight)
	self.tag = tag or ""
	
	if text then
		self.isLabel = false
	else
		self.isLabel = true
	end
	self.text = text or ""

	self.color={50,50,50,255}
	self.enable = true
	table.insert(self.parent.ui, self)
	self.editable = false
end

function textInput:onClick()
	if self.isLabel then return end
	self.text = ""
	self.editable = true
end

function textInput:check(x,y)
	if x< self.x-self.w/2 or x>self.x+self.w/2 then return false end
	if y< self.y-self.h/2 or y>self.y+self.h/2 then return false end
	return true
end

function textInput:update()
	self.hover=self:check(self.parent.mousex,self.parent.mousey)
	if self.hover and love.mouse.isDown(1) then
		if self.onDown then self.onDown(self) end
		self.down=true
	elseif self.hover and not love.mouse.isDown(1) and self.down then
		if self.onClick  and self.enable then self.onClick(self) end
		self.down=false
	end

end




function textInput:input(text)
	if not self.editable or self.isLabel then return end
	self.text = self.text .. text
end

function textInput:keypressed(key)
	if key == "return" then
		self.editable = false
		if self.onEnter then self:onEnter() end
	elseif key == "backspace" then       
        local byteoffset = utf8.offset(self.text, -1)
 
        if byteoffset then         
            self.text = string.sub(self.text, 1, byteoffset - 1)
        end
	end
end

function textInput:draw()
	love.graphics.setLineWidth(2)
	local r,g,b,a=unpack(self.color)
	if not self.enable then
		r,g,b = 150,150,150
	end
	if not self.hover then a=a*3/4 end
	local offx,offy=0,0
	--if self.down then offx=3;offy=3 end
	
	love.graphics.setColor(r,g,b,a)
	love.graphics.rectangle("line", self.x+offx - self.w/2, self.y+offy -self.h/2, self.w, self.h,self.w/8,self.h/8)
	love.graphics.setColor(r,g,b,a/1.1)
	love.graphics.rectangle("fill", self.x+offx -self.w/2, self.y+offy - self.h/2, self.w, self.h,self.w/8,self.h/8)
	--love.graphics.setColor(r, g, b, a)
	--love.graphics.rectangle("fill", self.x+offx -0.9*self.w/2, self.y+offy - 0.9*self.h/2, self.w*0.9, self.h*0.9)
	if self.editable then
		love.graphics.setColor(0, 255, 0, 255)
	else
		love.graphics.setColor(50, 50, 50, 0)
	end
	love.graphics.rectangle("line", self.x+offx -0.85*self.w/2, self.y+offy - 0.6*self.h/2, self.w*0.85, self.h*0.6)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(self.font)
	love.graphics.printf(self.tag..self.text, self.x+offx - self.w/2, self.y+offy+self.h/4 - self.h/2, self.w, "center")
end

return textInput