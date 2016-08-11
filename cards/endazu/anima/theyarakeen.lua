local data = {
	img_name = "yarakeen",
	name = "the Yarakeen",
	faction = "endazu",
	category = "anima",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 8,
	back = true,
	chargeInit = 1,
	chargeMax = 20,
	chargeMin = 1,
	last = true,
	hp = 5,
	undead = true
}

data.description = {
	"1/5 charge",
 	"hold: permanent +2 charge",
 	"turn: for each charge, attack",
}

data.ability={
	onTurnStart = function (card,game)
		for i = 1, card.charge do
			game:attack(card)
		end
	end,
	onHold = function(card,game)
		game:chargeCard(card,true)
		game:chargeCard(card,true)	
	end
}

return data