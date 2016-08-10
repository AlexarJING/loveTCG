local data = {
	img_name = "riteofclan",
	name = "Ceremonial Dance",
	faction = "daramek",
	category = "rituals",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 8,
	back = true,
	last = true
}

data.description = {
	"Next card you buy",
	"Gain a copy",
}

data.ability={

	onTurnStart = function (card,game)
		card.lastBought = game.lastBought
	end,
	onCardBuy = function (card,game,bought)
		local copy = game:copyCard(bought)
		game:transferCard(copy,game.my.hand)
		game:killCard(card)
	end,
	
}

return data