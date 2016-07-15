local scene = gamestate.new()
local Builder = require "cls/builder"
local Card = require "cls/card"


function scene:init()
	
	self.camera = Camera()
	self.camera:lookAt(0,0)
end 

function scene:enter(cur,from,data)
	builder = Builder(data)
end


function scene:draw()
	self.camera:attach()
	builder:draw()
	self.camera:detach()
end



function scene:update(dt)
	builder.mousex, builder.mousey = self.camera:mousepos() 
    builder:update(dt)
    builder.click=false
    builder.rightClick = false
end 

function scene:keypressed(key)
	if key == "space" then
		builder.pocket:save()
	end
end

function scene:mousepressed(x,y,key)
	if key == 1 then
		builder.click = true
	else 
		builder.rightClick = true
	end
end

function scene:leave()
end
return scene