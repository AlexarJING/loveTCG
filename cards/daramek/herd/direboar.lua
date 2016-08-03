local data = {
	id = "warpigs",
	name = "Dire Boar",
	faction = "daramek",
	category = "herd",
	rare = 3 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 10,
	hp = 5,
	last = true,
	back = true,
}

data.description = {
	"On turn/feed: Attack x3",
	"Sacrifice weakest ally" 
}

data.ability={
	onTurnStart = function (card,game) 
		game:attack(card)
		game:attack(card)
		game:attack(card)
		game:sacrificeCard("weakest")
	end,
}

return data