local data = {
	id = "fief",
	name = "fief",
	faction = "vespitole",

	category = "prosperity",
	rare = 2 ,

	profile = {"By Penderach's decree, all profits pulled from the soil from the White Hill to the River Wren must pass through my fingers first. –Prince Vico"},


	basePrice = 9,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +2 gold"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","gold")
		game:gain(card,"my","gold")
	end,
}

return data