local data = {
	id = "catapult",
	name = "catapult",
	faction = "vespitole",
	category = "war",
	rare = 3 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 8,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"play: draw a card",
	"turn: attack x3",
	"ignores intercept"

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card,nil,true) end,
}

return data