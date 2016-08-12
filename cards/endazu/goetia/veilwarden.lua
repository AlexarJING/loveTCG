local data = {
	img_name = "retaliategoetia",
	name = "Veil Warden",
	faction = "endazu",
	category = "goetia",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
	chargeInit = 1,
	chargeMax = 20,
	hp = 5,
	foodType = "hp",
	intercept =true
}

data.description = {
	"1/20 charge",
 	"Feed Life: heal",
 	"on attacked, +1 charge",
 	"on killed, attack x charge"
}

data.ability={

	onFeed = function(card,game)
		game:healCard(card)
	end,

	onAttacked = function(card,game,from)
		game:chargeCard(card)
	end,

	onKilled = function (card,game)
		for i = 1, card.charge do
			game:attack(card)
		end
	end
}

return data