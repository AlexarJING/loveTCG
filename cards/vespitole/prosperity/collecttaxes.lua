local data = {
	img_name = "collecttaxes",
	name = "Collect Taxes",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"Those who cannot pay in coin, cloth, or salt will pay in blood, bruises, and broken bones. –Constable Uberti"},

	basePrice = 6,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +1 gold"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","gold")
	end,
}

return data