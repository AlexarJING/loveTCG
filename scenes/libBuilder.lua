local scene = gamestate.new()
local Builder = require "cls/builder"
local Card = require "cls/card"


function scene:init()
	builder = Builder()
	self.camera = Camera()
	self.camera:lookAt(0,0)
end 

function scene:enter(from,to,time,how,...)

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
		builder.turnButton:endturn()
	elseif key == "lctrl" then
		builder:refillCard()
	elseif key == "1" then
		if builder.hoverCard then builder.hoverCard:vibrate() end
	elseif key == "2" then
		if builder.hoverCard then builder.hoverCard:standout() end
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