local builder = Class("builder")

local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"
--local userdata = require "userdata"
local Selector = require "cls/selector"
local Collection = require "cls/collection"
local Pocket = require "cls/pocket"
local Menu = require "cls/menu"
local Info = require "cls/info"



function builder:init()
	self.info = Info(self)
	self.userdata = self.info.data
	
	self.font_title = love.graphics.newFont(30)
	self.font_content = love.graphics.newFont(20)

	self.selector = Selector(self)
	self.collection = Collection(self)
	self.pocket = Pocket(self)
	self.menu = Menu(self)
	self.info = Info(self)

	self.state = "menu"
	self.coins = {}
end

function builder:initEditor()
	self.state = "edit"
end



function builder:update(dt)
	if self.state == "menu" then	
		self.selector:update(dt)
		self.menu:update(dt)
	else
		self.hoverCard = nil
		self.selector:update(dt)
		self.collection:update(dt)
		self.pocket:update(dt)
		self.click = false
		self.rightClick = false
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
end

return builder