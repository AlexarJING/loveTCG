local data = {
	img_name = "zalasair",
	name = "Zalasair",
	faction= "endazu",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = "E",
	hp = 35
}

data.description = {
	"Feed any Anima:",
	"It gains +1 permanent ", 
}

data.ability={

	onTurnStart = function(card,game)
		game:healCard(card)
	end
}

return data