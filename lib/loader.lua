local loader = {}


function loader.addPack(parent,func,sceneName,text)
	loader.parent = parent
	loader.running = true
	loader.co = coroutine.create(func)
	loader.scene = loader.scene or require (sceneName)
	loader.scene:load()
	loader.speed = 1
	loader._update = loader.parent.update
	loader._draw = loader.parent.draw
	loader.parent.update = loader.update
	loader.parent.draw = loader.draw
	loader.text = text or "loading"
	loader.scene.text = loader.text
	coroutine.resume(loader.co)
end

function loader.update(obj,dt)
	for i = 1 , loader.speed do
		if coroutine.status(loader.co) == "dead" then 
			loader.running = false
			loader.parent.update = loader._update
			loader.parent.draw = loader._draw
			break
		end
		coroutine.resume(loader.co)
	end
	loader.scene:update(dt)
end

function loader.draw()
	loader.scene:draw()
end

return loader