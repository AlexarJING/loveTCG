local scene = gamestate.new()
local Shop = require "cls/shop"

function scene:init()
	self.camera = Camera()
	self.camera:lookAt(0,0)
	self.shop = Shop(self)	
end 



function scene:draw()
	self.camera:attach()
	self.shop:draw()
	self.camera:detach()
end



function scene:update(dt)
	self.shop:update(dt)
end 

function scene:keypressed(key)
	self.shop:keypressed(key)
end


function scene:textinput(text )
	self.shop:textinput(text)
end

return scene