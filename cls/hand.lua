Class = require "lib.middleclass"
local hand = Class("hand")

function hand:init(root)
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position(self.go)
    self.maxCount = 4
    self.root = root
end


function hand:resort()
	if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local pos = go.get_position(self.go)
            pos.x = pos.x +( -#self.cards/2 +i -0.5) *CARD_WIDTH
            pos.z = i / 100
            go.animate(card.go,"position",go.PLAYBACK_ONCE_FORWARD, pos , go.EASING_INBACK, 0.5)
        end
    else
        for i,card in ipairs(self.cards) do
            local pos = go.get_position(self.go)
            pos.x = pos.x +( -self.maxCount/2 + (i-1)*self.maxCount/ #self.cards ) *CARD_WIDTH 
            pos.z = i / 100
            go.animate(card.go,"position",go.PLAYBACK_ONCE_FORWARD, pos , go.EASING_INBACK, 0.5)
        end
    end
end

function hand:draw()
	local cards = game[self.root].deck.cards
	if not cards[1] then return end

	local card =cards[math.random(#cards)]
	card:transfer(game[self.root].deck,self)
end

function hand:play(card)
	card:transfer(self,game[self.root].play,true)
end

function hand:discard()
	if #self.cards>self.maxCount then
		for i = self.maxCount,#self.cards do
			card:transfer(self.cards, card.born.deck.cards) --回到出生地，尚未更改
		end
	end
end

return hand