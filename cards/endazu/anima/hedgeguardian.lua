local data = {
	img_name = "hedgeguardian",
	name = "Hedge Guardian",
	faction = "endazu",
	category = "anima",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 1,
	chargeMax = 5,

	memory = true,
	intercept=true
}

data.description = {
	"1/5 charge",
 	"hold: permanent +1 charge",
 	"1 hp per charge,intercept",
 	"If attacked: summon flower",
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
	end,

	onHold = function(card,game)
		game:chargeCard(card)	
	end,

	onAttacked = function(card,game,from)
		game:summon("argorethflower")
	end
}

return data