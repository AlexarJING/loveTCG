local data = {
	id = "herdofrats",
	name = "Herd of Rats",
	faction = "daramek",
	category = "herd",
	rare = 1 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 2,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"turn: foe loses 1 resource",
}

data.ability={
	onTurnStart = function (card,game) 
		game:lose(card,"your","random")		--card,who,what
	end,
}

return data