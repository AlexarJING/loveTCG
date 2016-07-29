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
		card.lastBought = game.lastBought
	end,
	onTurnStart = function (card,game)
		card.lastBought = game.lastBought
	end,
	always = function (card,game)
		if card.current.root ~= game.turn then return end
		if game.lastBought ~= card.lastBought then
			local copy = game:copyCard( game.cardBought)
			game:transferCard(copy,copy.current,game.my.hand)
			game:killCard(card)
		end
	end,
	
}

return data