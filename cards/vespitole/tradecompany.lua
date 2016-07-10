local data = {
	id = "tradecompany",
	name = "trade company",
	faction = "vespitole",

	category = "prosperity",
	rare = 2 ,

	profile = {" city suckles at the ports for milk, and those that control the ships drink only cream. –Captain Listrata"},

	basePrice = 9,

	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +2 food"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","food")
		game:gain(card,"my","food")
	end,
}

return data