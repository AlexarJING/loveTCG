local builder = Class("builder")


function builder:init()
	self.name = "builder"
	--loader.addPack(self,function()
	self.ui = {}
	self.info = info
	self.userdata = self.info.data.collection
	self.font_title = love.graphics.newFont(30)
	self.font_content = love.graphics.newFont(20)
	self.selector = Selector(self)
	self.collection = Collection(self)
	self.pocket = Pocket(self)
	self.menu = Menu(self)
	self.cursor = Cursor(self)
	self.state = "menu"
	--end,"lib/loading")
end

function builder:initEditor()
	self.state = "edit"
end



function builder:update(dt)
	self.hoverCard = nil
	self.hoverUI = nil
	
	if self.state == "menu" then	
		self.selector:update(dt)
		self.menu:update(dt)
	else
		self.selector:update(dt)
		self.collection:update(dt)
		self.pocket:update(dt)
		self.click = false
		self.rightClick = false
	end

	for i,v in ipairs(self.ui) do
		v:update(dt)
	end
end

local hoverColor = {255, 0, 0, 255}

function builder:draw()
	
	if self.state == "menu" then
		self.selector:draw()
		self.menu:draw()
	else
		self.selector:draw()
		self.collection:draw()
		self.pocket:draw()
		if self.hoverCard then
			self.hoverCard:draw(hoverColor)
		end
	end

	self.info:draw()

	for i,v in ipairs(self.ui) do
		v:draw()
	end
end

return builder