local data = {
	id = "twilightpeacock",
	name = "Twilight Peacock",
	faction = "endazu",
	category = "anima",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 1,
	chargeMax = 5,

	memory = true,
	intercept=true
}

data.description = {
	"1/5 charge",
 	"hold: permanent +1 charge",
 	"1 hp per charge",
 	"On turn: Heal charge allies ",
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
	end,

	onHold = function(card,game)
		game:chargeCard(card)	
	end,

	onTurnStart = function(card,game,from)
		for i = 1, card.charge do
			game:heal()
		end
	end
}

return data