local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(40)
game.font_content = love.graphics.newFont(20)

local Card = require "cls/card"

local card = Card(game,game.cardData.green.coin)
function game:init()
	game.bg = require "cls/bg"()
end


function game:draw()
	game.bg:draw()
	card:draw()
end

return game


