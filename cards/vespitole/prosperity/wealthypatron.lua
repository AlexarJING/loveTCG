local data = {
	id = "wealthypatron",
	name = "Wealthy Patron",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"Though many others wage their wars with armies, mine are waged with gold. –Baronessa Vittoria"},

	basePrice = 6,
	hp = 1,

	block = false,

	last = true,

	back = true,
}

data.description = {
	"turn: +2 gold",
	"feed: +1 gold",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) game:gain(card,"my","gold");game:gain(card,"my","gold") end,
	onFeed = function(card,game) game:gain(card,"my","gold") end,
}

return data