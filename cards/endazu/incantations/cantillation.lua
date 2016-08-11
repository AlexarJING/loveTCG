local data = {
	img_name = "cantillation",
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
 	"+ charge to random inscription",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		for i = 1, card.charge do
			game:chargeCard("random",false,"inscription") --card,permanent,category,from)
		end
	end,
}

return data