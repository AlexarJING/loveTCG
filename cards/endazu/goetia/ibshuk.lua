local data = {
	id = "ibshuk",
	name = "Ibshuk",
	faction = "endazu",
	category = "goetia",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 5,
	hp = 1,
	canFeedLife = true,
	memory =true

}

data.description = {
	"1/5 charge",
 	"1 hp per charge",
 	"Feed 2 Life: permanent +1 charge",
 	"On turn: attack weakest",
 	"If attacked: +1 magic"
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
	end,

	onFeed = function(card,game)
		if game:feedCard(card) then
			game:chargeCard(card)
		else
			game:gain(card,"my","hp") 
		end
	end,

	onTurnStart = function(card,game,from)
		game:attack(card,"weakest")
	end,

	onAttacked = function (card,game)
		game:gain(card,"my","magic")
	end
}

return data