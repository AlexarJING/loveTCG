local data = {
	img_name = "captainviatrix",
	name = "Captain Listrata",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 1,
	hp = 30
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