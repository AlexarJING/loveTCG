local rnd = {}

function rnd:new(seed)
	self.generator = love.math.newRandomGenerator(seed or os.time())
end

function rnd:setSeed(seed)
	self.generator:setSeed(seed)
end

function rnd:getState()
	return self.generator:getState()
end

function rnd:setState(state)
	return self.generator:setState(state)
end

function rnd:random(...)
	return self.generator:random(...)
end

function rnd:table(tab)
	return tab[self.generator:random(#tab)]
end

function rnd:pickTable(tab)
	local index = self.generator:random(#tab)
	local target = tab[index]
	table.remove(tab,index)
	return target
end

return rnd