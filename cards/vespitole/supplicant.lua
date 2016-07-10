local data = {
	id = "supplicant",
	name = "supplicant",
	faction = "vespitole",

	category = "faith",
	rare = 2 ,

	profile = {"The rumors are true: The church hosts a secret order of thaumaturges that have trained countless generations of Vespitole in their dark arts.–Inquisitor Ferri"},

	basePrice = 7,
	hp = 2,

	block = false,

	last = true,

	back = true,
}

data.description = {
	"turn: +1 magic",
	"feed: +1 magic",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:gain(card,"my","magic")
		game:gain(card,"my","magic") 
	end,
	onFeed = function(card,game)
		game:gain(card,"my","magic")
		game:gain(card,"my","magic") 
	end,
}

return data