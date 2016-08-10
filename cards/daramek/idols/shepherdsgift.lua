local data = {
	img_name = "shepherdmonument",
	name = "Shepherd's Gift",
	faction = "daramek",
	category = "idols",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 5,
	last = true,
	back = true,
}

data.description = {
	"turn: +1 random resource",
}

data.ability={
	onTurnStart = function(card,game)
		game:gain(card,"my","random")
	end
}

return data