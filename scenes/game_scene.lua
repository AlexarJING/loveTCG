local scene = gamestate.new()
local Game = require "cls/game"

function scene:init()
	
	self.camera = Camera()
	self.camera:lookAt(0,0)
end 

function scene:enter(from,to,...)
	game = Game(...)
end


function scene:draw()
	self.camera:attach()
	game:draw()
	self.camera:detach()
end



function scene:update(dt)
	game.mousex, game.mousey = self.camera:mousepos() 
    game:update(dt)
    game.click=false
    game.rightClick = false
end 

function scene:keypressed(key)
	game:keypress(key)
	
end

function scene:mousepressed(x,y,key)
	if key == 1 then
		game.click = true
	else 
		game.rightClick = true
	end
end

function scene:leave()
end
return scene