local data = {
	id = "ballista",
	name = "ballista",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 6,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"play: draw a card",
	"turn: attack x2",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card) end,
}

return data