local scene = gamestate.new()
local Starter = require "cls/starter"

function scene:init()
	self.camera = Camera()
	self.camera:lookAt(0,0)
	self.starter = Starter(self)	
end 



function scene:draw()
	self.camera:attach()
	self.starter:draw()
	self.camera:detach()
end



function scene:update(dt)
	self.starter:update(dt)
end 

function scene:keypressed(key)
	self.starter:keypressed(key)
end


function scene:textinput(text )
	self.starter:textinput(text)
end

return scene