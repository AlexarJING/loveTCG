local data = {
	id = "odashirsecho",
	name = "Odashir's Echo",
	faction = "endazu",
	category = "incantations",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	chargeInit = 0,
	chargeMax = 3,
}

data.description = {
	"0/3 charge",
 	"On hold: +1 charge",
 	"On play and full charge",
 	"Copy any card",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		local candidate = {}
		for i,v in ipairs(game.my.play.cards) do
			table.insert(candidate,v)
		end
		for i,v in ipairs(game.your.play.cards) do
			table.insert(candidate,v)
		end
		for i,v in ipairs(candidate) do
			local copy = game:copyCard(v)
			copy.born = game.my
			game:transferCard(copy,copy.current,game.my.hand)
		end
	end,
}

return data