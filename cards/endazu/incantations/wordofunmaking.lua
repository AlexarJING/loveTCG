local data = {
	id = "wordofunmaking",
	name = "Word of Unmaking",
	faction = "endazu",
	category = "incantations",
	rare = 3,
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
 	"Summon Argoreth Flower ",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		if card.charge<chargeMax then return end
		for i,v in ipairs(game.my.play.cards) do
			game:destroyCard(v)
		end
		for i,v in ipairs(game.your.play.cards) do
			game:destroyCard(v)
		end
	end,
}

return data