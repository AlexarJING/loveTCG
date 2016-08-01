local data = {
	id = "vintner",
	name = "Vintner",
	faction = "vespitole",

	category = "prosperity",
	rare = 1 ,

	profile = {"Though the armies will march many miles on beef and bread, wine keeps them from feeling their feet! –Vintner Vinchenzo"},

	basePrice = 6,
	hp = 1,
	block = false,
	last = true,
	canFeedGold = true,
	back = true,
	charge =0
}

data.description = {
	"turn: +2 food",
	"feed 2 gold: +1 food",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:gain(card,"my","food")
		game:gain(card,"my","food") 
	end,
	onFeed = function(card,game)
		card.charge = card.charge + 1
		card:updateCanvas()
		if card.charge >= 2 then
			card.ability.onFullCharge(card,game)
		end
	end,

	onFullCharge = function(card,game)
		game:gain(card,"my","food") 
		card.charge = 0
		card:updateCanvas()
	end
}

return data