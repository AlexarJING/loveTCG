local jump = {}


function jump.to(parent,pos, sceneName)
	jump.parent = parent
	jump.scene = jump.scene or require (sceneName)
	jump.scene:load(pos)
	jump._update = jump.parent.update
	jump._draw = jump.parent.draw
	jump.parent.update = jump.update
	jump.parent.draw = jump.draw
	jump.running = true
end

function jump.update(parent,dt)

	if jump.scene.update(dt) then
		jump.goback()
	end
	jump._update(parent,dt)
end

function jump.goback()
	jump.parent.update = jump._update
	jump.parent.draw = jump._draw
	jump.running = false
end

function jump.draw(parent)
	love.graphics.setColor(100, 100, 100, 255)
	jump._draw(parent)
	love.graphics.setColor(255, 255, 255, 255)
	jump.scene:draw()
end

return jump