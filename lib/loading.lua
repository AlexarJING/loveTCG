local Bg = require "cls/bg"
local scene = {}

function scene:load()
	self.bg = Bg("startbg",0,0,2)
	self.bg2 = Bg("title",0,0,2)
	self.font = love.graphics.newFont("res/others/start.ttf", 50)
	self.string = "war of omens  war of omens  war of omens"
	self.offangle = 0

	self.banner={}
	for i = 1,30 do
		local b = {text = self.string, 
		x = love.math.random(-2000,2000),
		y = love.math.random(-360,360),
		scale =love.math.random()*0.8+0.6,
		o = 1- love.math.random(0,1)*2}
		table.insert(self.banner, b)
	end

	self.alpha= 100
	self.da = 10
end


function scene:update(dt)
	
	for i,b in ipairs(self.banner) do
		b.x = b.x + b.o*5
		if b.x>2000 then b.x = -2000 end
		if b.x<-2000 then b.x = 2000 end
	end
	self.alpha = self.alpha + self.da
	if self.alpha>=255 or self.alpha<=0 then
		self.da = -self.da
	end
end



function scene:draw()

	self.bg:draw()
	local len = self.string:len()
	local angle
	love.graphics.setColor(50, 50, 50, 255)
	love.graphics.setFont(self.font)
	self.offangle= self.offangle+0.01
	for i = 1, len do
		angle = i* (math.pi*2)/len+self.offangle
		love.graphics.print(self.string:sub(len-i,len-i), 250*math.cos(angle), 250*math.sin(angle), angle-math.pi/2, 2 , 2)
	end
	for i,v in ipairs(self.banner) do
		love.graphics.print(v.text, v.x, v.y, 0, v.scale, v.scale)
	end
	self.bg2:draw()
	love.graphics.setColor(200,0,0,self.alpha)
	love.graphics.print("loading", 300,100,0,2,2)
end


return scene