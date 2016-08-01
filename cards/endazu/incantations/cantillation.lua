local data = {
	id = "cantillation",
	name = "Cantillation",
	faction = "endazu",
	category = "incantations",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 1,
	chargeMax = 20,
}

data.description = {
	"1/20 charge",
 	"On hold: +1 charge",
 	"On play: for each charge",
 	"+ charge to random insciption",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		--
	end,
}

return data