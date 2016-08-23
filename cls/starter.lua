local starter = Class("starter")

local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"
local Bg = require "cls/bg"
local Button = require "cls/button"
local Text = require "cls/text"
local Info = require "cls/info"



function starter:init(parent)
	self.info = Info(self)
	self.parent = parent
	self.bg = Bg("startbg",0,0,2)
	self.bg2 = Bg("title",0,0,2)
	self.font = love.graphics.newFont("res/others/start.ttf", 50)
	self.string = "war of omens war of omens war of omens"
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


	self.ui = {}
	self.input = Text(self,-100,-100,300,100,"id:","your name")
	self.confirm = Button(self,150, -100 ,150,80,"confirm")
	self.confirm.onClick = function(btn)
		if btn.text == "confirm" then			
			if self.input.text ~= self.info.data.name then
				self.info:newUserFile(self.input.text)
			end
			
			--------------------------------------------------------
			love.client:emit("login",{name = self.info.data.name})
			love.client:on("login",function(data) love.connectionID = data end)
			love.client.reconnect = function()
				love.client:emit("login",{name = self.info.data.name})
			end

			----------------------------------------------------------------------
			self:toBuilder()
		elseif btn.text == "delete" then
			self.info:newUserFile("default")
		elseif btn.text == "change" then
			self.input.isLabel = false
			self.input.editable = true
			self.data = nil
		end
	end
	local data = self.info.data
	
	self.input.text = data.name
	self.input.isLabel = true
	
end


function starter:toBuilder()
	--gamestate.switch(gameState.inter,gameState.builder_scene) 
	gamestate.switch(gameState.builder_scene) 
end

function starter:update(dt)

	self.mousex, self.mousey = self.parent.camera:mousepos() 
 	if love.keyboard.isDown("lctrl") then
 		self.confirm.text = "change"
 	elseif love.keyboard.isDown("lalt") then
 		self.confirm.text = "delete"
 	else
 		self.confirm.text = "confirm"
 	end

	for i,b in ipairs(self.banner) do
		b.x = b.x + b.o*5
		if b.x>2000 then b.x = -2000 end
		if b.x<-2000 then b.x = 2000 end
	end
	for i,v in ipairs(self.ui) do
		v:update(dt)
	end

	
end



function starter:draw()

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
	
	for i,v in ipairs(self.ui) do
		v:draw()
	end

end


function starter:keypressed(key)
	self.input:keypressed(key)
end
function starter:textinput(text )
	self.input:input(text)
end

return starter