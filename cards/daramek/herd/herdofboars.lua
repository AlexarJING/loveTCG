local data = {
	id = "herdofboars",
	name = "Herd of Boars",
	faction = "daramek",
	category = "herd",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	hp = 3,
	last = true,
	back = true,
}

data.description = {
	"On turn: Attack",
	"on killed: +2 resources ",
}

data.ability={
	onTurnStart = function (card,game) 
		game:attack(card)
	end,
	onKilled = function(card,game)
		game:gain(card,"my","random")
		game:gain(card,"my","random")
	end
}

return data