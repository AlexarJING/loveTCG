local scene = gamestate.new()

function scene:init()
	self.camera = Camera()
	self.camera:lookAt(0,0)
	 --"lose"	
end 

function scene:enter(from,...)
	self.result = Result(self,...) --parent,screenshot,hero,result
end

function scene:draw()
	self.camera:attach()
	self.result:draw()
	self.camera:detach()
end



function scene:update(dt)
	self.result:update(dt)
end 


return scene