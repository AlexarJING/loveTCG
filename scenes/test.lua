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
	game.mousex, game.mousey = self.camera:mousepos() 
    game:update(dt)
    game.click=false
    game.rightClick = false
end 

function scene:keypressed(key)
	if key == "space" then
		game.turnButton:endturn()
	elseif key == "lctrl" then
		game:refillCard()
	elseif key == "1" then
		if game.hoverCard then game.hoverCard:vibrate() end
	elseif key == "2" then
		if game.hoverCard then game.hoverCard:standout() end
	end
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