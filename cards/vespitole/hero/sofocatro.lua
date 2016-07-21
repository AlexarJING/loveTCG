local data = {
	id = "sofocatro",
	name = "sofocatro",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
}

data.description = {
	"turn: +1 skull",
}

data.ability={	
	onTurnStart = function(card,game) 
		game:gain(card,"my","skull")
	end,
}

return data