Class = require "lib.middleclass"
local show = Class("show")

function show:init()
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position()
    self.maxCount = 10
end


function show:resort()
	
	if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local pos = go.get_position(self.go)
            pos.x = pos.x +( -#self.cards/2 +i -0.5) *CARD_WIDTH
            pos.z = 1
            go.animate(card.go,"position",go.PLAYBACK_ONCE_FORWARD, pos , go.EASING_INBACK, 0.5)
        end
    else
        for i,card in ipairs(self.cards) do
            local pos = go.get_position(self.go)
            pos.x = pos.x +( -self.maxCount/2 + (i-1)*self.maxCount/ #self.cards ) *CARD_WIDTH 
            pos.z = 1
            go.animate(card.go,"position",go.PLAYBACK_ONCE_FORWARD, pos , go.EASING_INBACK, 0.5)
        end

    end
end

function show:addCards(card,from)
	card:transfer(from,self)
	self.cardFrom = from
	go.animate(card.go,"scale",go.PLAYBACK_ONCE_FORWARD, go.get(card.go,"scale")*2 , go.EASING_LINEAR, 0.5)
end

function show:select(card,targetTo,elseTo)
	for i,v in ipairs(self.cards) do
		go.animate(v.go,"scale",go.PLAYBACK_ONCE_FORWARD, go.get(v.go,"scale")/2 , go.EASING_LINEAR, 0.5)
		if v == card then
			card:transfer(self, targetTo or self.cardFrom)
		else
			card:transfer(self, elseTo or self.cardFrom)
		end
	end
end

return show