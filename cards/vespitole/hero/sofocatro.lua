local data = {
	img_name = "sofocatro",
	name = "Sofocatro",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
	hp = 30
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