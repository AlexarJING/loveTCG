local scene = gamestate.new()
local Builder = require "cls/builder/builder"
local Card = require "cls/game/card"


function scene:init()
	
	self.camera = Camera()
	self.camera:lookAt(0,0)
	
end 

function scene:enter(cur,from)
	self.builder = Builder()
end


function scene:draw()
	self.camera:attach()
	self.builder:draw()
	self.camera:detach()
end



function scene:update(dt)
	self.builder.mousex, self.builder.mousey = self.camera:mousepos() 
    self.builder:update(dt)
    self.builder.click=false
    self.builder.rightClick = false
end 



function scene:mousepressed(x,y,key)
	if key == 1 then
		self.builder.click = true
	else 
		self.builder.rightClick = true
	end
end

function scene:leave()
	self.builder.collection.cards=nil
	collectgarbage("collect")
end
return scene