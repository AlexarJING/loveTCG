local data = {
	id = "ceremonialdance",
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
	onPlay = function (card,game)
		game.onBuy = function(cardBought)
			if cardBought.id==card.id then return end
			local copy = game:copyCard(cardBought)
			game:transferCard(copy,copy.current,game.my.hand)
			game.onBuy = nil
		end
	end,
	
}

return data