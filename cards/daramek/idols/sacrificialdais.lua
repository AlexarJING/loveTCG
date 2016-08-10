local data = {
	img_name = "sacrificialdais",
	name = "Sacrificial Dais",
	faction = "daramek",
	category = "idols",
	rare = 3 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	last = true,
	back = true,
}

data.description = {
	"on Sacrifice an Ally",
	"+1 random resource",
}

data.ability={
	onSacrificeAlly = function(card,game)
		game:gain(card,"my","random")
	end
}

return data