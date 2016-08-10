local data = {
	img_name = "vintner",
	name = "Vintner",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"Though the armies will march many miles on beef and bread, wine keeps them from feeling their feet! –Vintner Vinchenzo"},

	basePrice = 6,
	hp = 1,
	intercept = false,
	last = true,
	foodType = "gold",
	feedAmout = 2,
	back = true,
}

data.description = {
	"turn: +2 food",
	"feed 2 gold: +1 food",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:gain(card,"my","food")
		game:gain(card,"my","food") 
	end,
	onFeed = function(card,game)
		game:gain(card,"my","food") 
	end,
}

return data