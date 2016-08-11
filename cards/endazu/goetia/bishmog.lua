local data = {
	img_name = "bishmog",
	name = "Bishmog",
	faction = "endazu",
	category = "goetia",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 5,
	chargeMin= 1,
	hp = 1,
	foodType = "hp",
	feedAmount = 3,
	connected = true
}

data.description = {
	"1/5 charge",
 	"1 hp per charge",
 	"Feed 3 Life: permanent +1 charge",
 	"On turn, for each charge:",
 	"self attack: +1 magic"
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
		card:updateCanvas()
	end,

	onFeed = function(card,game)
		game:chargeCard(card,true)
	end,

	onTurnStart = function(card,game,from)
		for i = 1, card.charge do
			game:attack(card,"infighting")
			game:gain(card,"my","magic")
		end
	end,

}

return data