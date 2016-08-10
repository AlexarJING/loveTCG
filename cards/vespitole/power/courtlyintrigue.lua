local data = {
	img_name = "courtlyintrigue",
	name = "Courtly Intrigue",
	faction = "vespitole",

	category = "power",
	rare = 1 ,

	profile = {"The whispers of idle rumors stoke the flames of funeral pyres. – Old Proverb"},

	basePrice = 6,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +1 skull"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","skull")
	end,
}

return data