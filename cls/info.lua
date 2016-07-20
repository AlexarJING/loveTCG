local info = Class("info")
local Button = require "cls/button"
local Bg = require "cls/bg"
local font = love.graphics.newFont(20)
local gold = love.graphics.newImage("res/others/coin.png")
local gem = love.graphics.newImage("res/others/gem.png")
local dust = love.graphics.newImage("res/others/steel.png")

function info:init(parent)
	self.parent = parent
	self.data = parent.userdata or self:readUserFile()
	self.id = self.data.name
	self.gem = self.data.gem
	self.gold= self.data.gold
	self.dust = self.data.dust
	self.x = -600
	self.y = -350
	self.w = 500
	self.h = 30
end


function info:update(dt)
	--self.mousex , self.mousey = self.parent.mousex , self.parent.mousey
	
end

function info:newUserFile(name)
	self.data ={
					name = name,
					gem = 0,
					gold = 0,
					dust =0,
					collection = require "cardLibs/default"	
				}

	self:saveUserFile()
end

function info:readUserFile()
	local file = love.filesystem.newFile("system", "r")
	if not file then
		return
	end
	local data = loadstring(file:read())()
	self.data = data
	file:close()
	return data
end

function info:saveUserFile()
	local file = love.filesystem.newFile("system", "w")
	local data = table.save(self.data)
	file:write(data)
	file:close()
end


function info:draw()
	love.graphics.setColor(50, 50, 255, 50)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(font)
	love.graphics.print("id: "..self.data.name, self.x,self.y)
	love.graphics.draw(dust, self.x+200,self.y)
	love.graphics.print(": "..tostring(self.data.dust), self.x+230,self.y)
	love.graphics.draw(gold, self.x+300,self.y)
	love.graphics.print(": "..tostring(self.data.gold), self.x+330,self.y)
	love.graphics.draw(gem, self.x+400,self.y)
	love.graphics.print(": "..tostring(self.data.gem), self.x+430,self.y)

end

return info