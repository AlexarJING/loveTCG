Class = require "lib.middleclass"
local play = Class("play")

function play:init(root)
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position()
    self.maxCount = 10
    self.root = root
end


function play:resort()
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

return play
