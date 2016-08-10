local data = {
	img_name = "bureaucrat",
	name = "bureaucrat",
	faction = "vespitole",

	category = "power",
	rare = 2 ,

	profile = {"I assume you have a signed permit to move an army through the West gates?  –Magistrate Veccio"},


	basePrice = 7,
	hp = 1,

	intercept = false,

	last = true,

	back = true,
}

data.description = {
	"play: draw a card",
	"turn: foe -1 resource",
	"feed: foe -1 resource"
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) game:lose(card,"your","random") end,
	onFeed = function(card,game) game:lose(card,"your","random") end,
}

return data