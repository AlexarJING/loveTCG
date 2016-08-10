local data = {
	img_name = "marshall",
	name = "Marshall",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 8,
	hp = 1,
	last = true,
	back = true,
	activator = true
}

data.description = {
	"play: draw a card",
	"turn: activate all allies",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game)
		game:activateCard(card,"all")
	end,
}

return data