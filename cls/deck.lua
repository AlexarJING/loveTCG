Class = require "lib.middleclass"
local deck = Class("deck")

function deck:init(root)
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position()
    self.root = root
end

function deck:addCards(cardData)
	for i,data in ipairs(cardData) do
        local card = factory.create("#card_proto",self.position,nil,
            {name = hashy[data.name],race = hashy[data.race],
            exp = data.exp , level = data.level , root = hashy[self.root]})
        table.insert(self.cards, game.cardIndex[card])
    end
end

return deck