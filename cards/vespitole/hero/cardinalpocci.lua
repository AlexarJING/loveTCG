local data = {
	id = "cardinalpocci",
	name = "cardinal pocci",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
}

data.description = {
	"turn: +1 gold",
}

data.ability={
	
	onTurnStart = function(card,game) 
		game:gain(card,"my","gold",1)
	end,
}

return data