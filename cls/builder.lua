local builder = Class("builder")

local Card = require "cls/card"
local cardData = require "cls/cardDataLoader"
local userdata = require "userdata"
local Selector = require "cls/selector"
local Collection = require "cls/collection"
local Pocket = require "cls/pocket"

function builder:init()
	---to remove---
	
	self.userdata = userdata
	
	self.font_title = love.graphics.newFont(30)
	self.font_content = love.graphics.newFont(20)

	self.selector = Selector(self)
	self.collection = Collection(self)
	self.pocket = Pocket(self)
end


function builder:update(dt)
	self.selector:update(dt)
	self.collection:update(dt)
	self.pocket:update(dt)
end


function builder:draw()
	self.selector:draw()
	self.collection:draw()
	self.pocket:draw()
end

return builder