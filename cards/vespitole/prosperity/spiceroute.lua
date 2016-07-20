local data = {
	id = "spiceroute",
	name = "Spice Route",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"Dalmiria is so rich in spices that a commoner will consume a lord's ransom in a single meal.–Captain Listrata"},

	basePrice = 6,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +1 food"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","food")
	end,
}

return data