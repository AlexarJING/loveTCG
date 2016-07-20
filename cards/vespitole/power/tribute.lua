local data = {
	id = "tribute",
	name = "Tribute",
	faction = "vespitole",

	category = "power",
	rare = 4 ,

	profile = {"The secret to wealth is to loan more gold than you have, and threaten more war than you can make. –Captain Listrata"},

	basePrice = 12,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +1 each resource "
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","gold")
		game:gain(card,"my","magic")
		game:gain(card,"my","food")
		game:gain(card,"my","skull")
	end,
}

return data