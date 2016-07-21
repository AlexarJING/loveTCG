local data = {
	id = "captainviatrix",
	name = "Captain Listrata",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 1,
}

data.description = {
	"turn: +1 food",
}

data.ability={
	onTurnStart = function(card,game) 
		game:gain(card,"my","food")
	end,
}

return data