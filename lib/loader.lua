local loader = {}

function loader.addPack(parent,func,sceneName)
	loader.parent = parent
	loader.running = true
	loader.co = coroutine.create(func)
	loader.scene = require (sceneName)
	loader.scene:load()
	loader.speed = 2
	loader._update = loader.parent.update
	loader._draw = loader.parent.draw
	loader.parent.update = loader.update
	loader.parent.draw = loader.draw
end

function loader.update(dt)
	for i = 1 , loader.speed do
		if coroutine.status(loader.co) == "dead" then 
			loader.running = false
			loader.parent.update = loader._update
			loader.parent.draw = loader._draw
			break
		end
		print(coroutine.resume(loader.co))
	end
	loader.scene:update(dt)
end

function loader.draw()
	loader.scene:draw()
end

return loader