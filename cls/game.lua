local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(40)
game.font_content = love.graphics.newFont(20)


local sides = {"up","down"}

function game:init()
	game.bg = require "cls/bg"()
	game.up = {}
	game.down = {}
	for i,side in ipairs(sides) do
		game[side].deck = require "cls/deck"(game,side)
		game[side].hand = require "cls/hand"(game,side)
	end
	game.turn = "down"
	game.my = game.down
	game.your = game.up
	game:drawCard()
end

function game:update(dt)
	for i,side in ipairs(sides) do
		game[side].deck:update(dt)
		game[side].hand:update(dt)
	end
end

function game:draw()
	game.bg:draw()
	for i,side in ipairs(sides) do
		game[side].deck:draw()
		game[side].hand:draw()
	end
end

function game:drawCard()
	local from = game.my.deck.cards
	local index = love.math.random(#from)
	local card = from[index]
	local to = game.my.hand.cards
	table.remove(from, index)
	table.insert(to , card)
	game.my.hand:resort()
end

return game


