local data = {
	img_name = "gildedwarrior",
	name = "Gilded Warriors",
	faction = "endazu",
	category = "anima",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 5,
	chargeMin = 1,
	last = true,
	hp = 1,
	connected = true
}

data.description = {
	"1/5 charge",
 	"hold: permanent +1 charge",
 	"1 hp per charge",
 	"turn: for each charge, attack",
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
		card:updateCanvas()
	end,
	onTurnStart = function (card,game)
		for i = 1, card.charge do
			game:attack(card)
		end
	end,
	onHold = function(card,game)
		game:chargeCard(card,true)	
	end
}

return data