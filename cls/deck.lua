local deck = Class("deck")
local Card = require "cls/card"

function deck:init(game,root)
    self.cards={}
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = -450
        self.y = -250
        self.rx = 3.14
    else
        self.x = 450
        self.y = 250
        self.rx = 3.14
    end
    self.scale = 1
   
end

function deck:goback(card)
    card:addAnimate(0.5,{y=self.y},"inBack")
    card:addAnimate(0.5,{x=self.x,rz=0,rx=3.14},"outQuad")
end
--[[
function deck:resort()
    for i,card in ipairs(self.cards) do
        card:animate(0.5,{y=self.y},"inBack")
        card:animate(0.5,{x=self.x,rz=0,rx=3.14},"outQuad")
    end
end
]]

function deck:setCards(data)
     
    for i,v in ipairs(data.deck) do
         local card = Card(self.game,self.game.cardData[data.faction][v],self.root,self)
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



return deck