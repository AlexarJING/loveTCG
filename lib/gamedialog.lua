local scene = {}
local Diag = require "cls/dialogbub"
local diag
function scene.load(parent,pos)
	diag = Diag(pos.x,pos.y,"testtesttesttesttesttesttesttest")
end


function scene.update(dt)
	diag:update(dt)
	if diag.done and love.keyboard.isDown("space") then return true end
end

function scene.draw()
	diag:draw()
end

return scene