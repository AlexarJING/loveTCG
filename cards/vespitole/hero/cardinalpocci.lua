local data = {
	img_name = "cardinalpocci",
	name = "cardinal pocci",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
	hp =30
}

data.description = {
	"turn: +1 gold",
}

data.ability={
	onTurnStart = function(card,game) 
		game:gain(card,"my","gold")
	end,
}

return data