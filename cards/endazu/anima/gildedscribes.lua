local data = {
	img_name = "gildedscribes",
	name = "Gilded Scribes",
	faction = "endazu",
	category = "anima",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 3,
	chargeMin = 1,
	last = true,
	hp = 1,
	connected = true

}

data.description = {
	"1/3 charge",
 	"hold: permanent +1 charge",
 	"1 hp per charge",
 	"turn: all charge",
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
		card:updateCanvas()
	end,
	onTurnStart = function (card,game)
		game:chargeCard("all")
	end,
	onHold = function(card,game)
		game:chargeCard(card,true)	
	end
}

return data