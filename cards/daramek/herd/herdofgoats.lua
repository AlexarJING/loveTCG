local data = {
	id = "herdogoats",
	name = "Herd of Goats",
	faction = "daramek",
	category = "herd",
	rare = 1 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 4,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"turn: gain 1 resource",
}

data.ability={
	onTurnStart = function (card,game) 
		game:gain(card,"my","random")		--card,who,what
	end,
}

return data