local data = {
	img_name = "argorathflower", --argorathflower
	name = "Argoreth Flower",
	faction = "endazu",
	category = "anima",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 1,
	chargeMax = 4,
	last = true,
	hp = 1,
	memory = true
}

data.description = {
	"1/4 charge",
 	"hold: permanent +1 charge",
 	"turn: for each charge, + magic",
}

data.ability={
	onTurnStart = function (card,game)
		for i = 1, card.charge do
			game:gain(card,"my","magic")
		end
	end,
	onHold = function(card,game)
		game:chargeCard(card)	
	end
}

return data