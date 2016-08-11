local data = {
	img_name = "twilightpeacock",
	name = "Twilight Peacock",
	faction = "endazu",
	category = "anima",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 1,
	chargeMax = 5,
	chargeMin = 1,
	connected = true
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
		card:updateCanvas()
	end,

	onHold = function(card,game)
		game:chargeCard(card,true)	
	end,

	onTurnStart = function(card,game,from)
		game:healCard("charge")	
	end
}

return data