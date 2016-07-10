local data = {
	id = "serf",
	name = "serf",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"no money, you can do nothing!"},

	basePrice = 5,
	hp = 1,

	block = true,



	last = true,

	back = true,
}

data.description = {
	"intercept",
	"play: draw a card",
}

data.ability={
	onPlay = function (card,game) game:drawCard() end 
}

return data