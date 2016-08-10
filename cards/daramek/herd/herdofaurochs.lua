local data = {
	img_name = "herdofoxen",
	name = "Herd of Aurochs",
	faction = "daramek",
	category = "herd",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 8,
	hp = 4,
	last = true,
	back = true,
}

data.description = {
	"On turn: +2 random resource",
	"When life reduced to 0",
	"25%: return to hand"
}

data.ability={
	onTurnStart = function (card,game) 
		game:gain(card,"my","random")
		game:gain(card,"my","random")
	end,
	onDying = function(card,game)
		if love.math.random()<0.25 then
			return "toHand"
		else
			return "death"
		end
	end
}

return data