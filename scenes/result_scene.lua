local scene = gamestate.new()
local Result = require "cls/result"


function scene:init()
	self.camera = Camera()
	self.camera:lookAt(0,0)
	self.result = Result(self,nil,"lose") --"lose"	
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