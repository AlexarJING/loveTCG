local data = {
	img_name = "masqueradeball",
	name = "Masquerade Ball",
	faction = "vespitole",

	category = "power",
	rare = 2 ,

	profile = {"Dalmiria is so rich in spices that a commoner will consume a lord's ransom in a single meal. –Captain Listrata"},

	basePrice = 9,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +2 skull"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","skull")
		game:gain(card,"my","skull")
	end,
}

return data