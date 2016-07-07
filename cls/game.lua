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
		game[side].bank = require "cls/bank"(game,side)
		game[side].library = require "cls/library"(game,side)
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
		game[side].bank:update(dt)
	end
end

function game:draw()
	game.bg:draw()
	for i,side in ipairs(sides) do
		game[side].deck:draw()
		game[side].hand:draw()
		game[side].bank:draw()
	end
end

function game:drawCard()
	local from = game.my.deck
	local index = love.math.random(#from.cards)
	local card = from.cards[index]
	local to = game.my.hand
	self:transferCard(card,from,to)
end


function game:refillCard()
	local from = game.my.library --data
	local index = love.math.random(#from.cards)
	local card = from:makeCard(from.cards[index])
	local to = game.my.bank
	self:transferCard(card,from,to)
end

function game:transferCard(card ,from,to )

	table.removeItem(from.cards, card)
	if from.resort then from:resort() end
	table.insert(to.cards, card)
	if to.resort then to:resort() end
	card.current = to
end

return game


