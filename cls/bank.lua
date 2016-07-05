Class = require "lib.middleclass"
local bank = Class("bank")

function bank:init(root)
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position()
    self.maxCount = 5
    self.root = root
end


function bank:resort()	
	if #self.cards <= self.maxCount then
        for i,card in ipairs(self.cards) do
        	
            local pos = go.get_position(self.go)
            if self.root == "down" then
                pos.y = i * 80 - 250
            else
                pos.y = -i * 80 + 250
            end
            pos.z = i / 100
            go.animate(card.go,"position",go.PLAYBACK_ONCE_FORWARD, 
            	pos , go.EASING_INBACK, 0.5)
            --go.animate(card.go,"rotation",go.PLAYBACK_ONCE_FORWARD, 
            --	vmath.quat_rotation_z(-3.14/5) , go.EASING_INBACK, 0.5)
        end
    else
        local card = self.cards[1]
        local pos = go.get_position()
        pos.y = pos.y - 500
        go.animate(card.go,"position",
        	go.PLAYBACK_ONCE_FORWARD, 
        	pos,
         	go.EASING_INBACK, 0.5,0,
        	function() card:destroy() end) 	
        table.remove(self.cards, 1)
    end
end


function bank:refill()
	local cards = game[self.root].library.cards
	if not cards[1] then return end
	
	local data = cards[math.random(#cards)]
    local card = factory.create("#card_proto",self.position,nil,
        {name = hashy[data.name],race = hashy[data.race],exp = data.exp ,
         level = data.level, root = hashy[self.root]})
    table.insert(self.cards, game.cardIndex[card])
	self:resort()
end

function bank:buy(card)
	local money = game[self.root].hero.money
    if card.price>money then
        print("not enough money")
    else
        --game[self.root]:lost("money",price)
		card:transfer(game[self.root].bank, game[self.root].play)
    end
end


return bank