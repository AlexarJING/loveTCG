local scene = gamestate.new()


function scene:init()
	self.camera = Camera()
	self.camera:lookAt(0,0)
	
end 

function scene:enter()
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


return scene