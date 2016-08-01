local data = {
	id = "banishinggust",
	name = "Banishing Gust",
	faction = "endazu",
	category = "incantations",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 0,
	chargeMax = 2,
}

data.description = {
	"0/2 charge",
 	"On hold: +1 charge",
 	"On play and full charge",
 	"Summon Argoreth Flower ",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		if card.charge<chargeMax then return end
		for i,v in ipairs(game.my.play.cards) do
			game:killCard(v)
		end
		for i,v in ipairs(game.your.play.cards) do
			game:killCard(v)
		end
	end,
}

return data