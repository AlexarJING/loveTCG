local data = {
	img_name = "inquisitor",
	name = "Inquisitor",
	faction = "vespitole",

	category = "faith",
	rare = 4 ,

	profile = {"Fill every empty space of the mind with agony so that lies have no refuge. Whatever remains is the truth. –Sodantis, Grand Inquisitor"},

	basePrice = 14,
	hp = 2,

	intercept = false,

	last = true,

	back = true,
}

data.description = {
	"turn/feed: +1 skull",
	"turn/feed: attack weakest",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:gain(card,"my","skull")
		game:attack(card,"weakest")
	end,
	onFeed = function(card,game)
		game:gain(card,"my","skull")
		game:attack(card,"weakest")
	end,
}

return data