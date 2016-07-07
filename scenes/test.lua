local scene = gamestate.new()
local Game = require "cls/game"
local Card = require "cls/card"


function scene:init()
	game = Game()
	self.camera = Camera()
	self.camera:lookAt(0,0)
end 

function scene:enter(from,to,time,how,...)

end


function scene:draw()
	self.camera:attach()
	game:draw()
	self.camera:detach()
end

function scene:update(dt)
    game:update(dt)
end 

function scene:keypressed(key)
	if key == "space" then
		game:drawCard()
	elseif key == "lctrl" then
		game:refillCard()
	end
end

function scene:leave()
end
return scene