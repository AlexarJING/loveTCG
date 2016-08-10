
local data = {
	img_name = "bloodbog",
	name = "Shrine of Rebirth",
	faction = "daramek",
	category = "idols",
	rare = "H" ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	last = true,
	back = true,
}

data.description = {
	"When you discard a card",
	"10% returns to your hand",
}

data.ability={
	onAllyDie = function(card,game,target)
		if love.math.random()<0.1 then
			target:reset()
			game:transferCard(target , target:getSide().hand)
			return true
		end
	end
}

return data