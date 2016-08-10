local data = {
	img_name = "boarfetish",
	name = "Boar Fetish",
	faction = "daramek",
	category = "idols",
	rare = 4 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	last = true,
	back = true,
}

data.description = {
	"on feed hero magic:", 
	"attack.",
}

data.ability={
	onFeedMagic = function(card,game)
		game:attack(card)
	end
}

return data