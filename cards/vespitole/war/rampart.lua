local data = {
	id = "rampart",
	name = "Rampart",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"A Mercenary is an Alchemist. He heats cold iron with hot blood, and from that crucible he pours gold. –Duchessa Cyneswith"},
	basePrice = 9,
	shield = 4,
	block = true,
	last = true,
	back = true,
}

data.description = {
	"intercept 4 attacks",
	"play: draw a card",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
}

return data