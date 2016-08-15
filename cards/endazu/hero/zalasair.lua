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
	"On turn: +1 Life",
	"Starts with +5 Life" 
}

data.ability={

	onTurnStart = function(card,game)
		game:healCard(card)
	end
}

return data