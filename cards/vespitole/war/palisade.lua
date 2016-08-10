local data = {
	img_name = "palisade",
	name = "Palisade",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"A Mercenary is an Alchemist. He heats cold iron with hot blood, and from that crucible he pours gold. –Duchessa Cyneswith"},
	basePrice = 5,
	charge = 2,
	intercept = true,
	last = true,
	back = true,
}

data.description = {
	"intercept 2 attacks",
	"play: draw a card",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
}

return data