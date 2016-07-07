local deck = Class("deck")
local Card = require "cls/card"

function deck:init(game,root)
    self.cards={}
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = -400
        self.y = -250
        self.rx = 3.14
    else
        self.x = 400
        self.y = 250
        self.rx = 3.14
    end

    for i = 1, 5 do
        local card = Card(game,game.cardData.green.coin,self)
        table.insert(self.cards, card)
    end
end

function deck:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function deck:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end

function deck:addCards(cardData)
	
end

return deck