local data = {
	id = "bishmog",
	name = "Bishmog",
	faction = "endazu",
	category = "goetia",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 3,
	hp = 1,
	canFeedLife = true,
	memory =true

}

data.description = {
	"1/5 charge",
 	"1 hp per charge",
 	"Feed 3 Life: permanent +1 charge",
 	"On turn, for each charge:",
 	"If attacked: +1 magic"
}

data.ability={
	onPlay = function(card,game)
		card.hp = card.charge
		card.hp_max = card.charge
	end,

	onFeed = function(card,game)
		if game:feedCard(card) then
			if game:feedCard(card) then
				game:chargeCard(card)
			else
				game:gain(card,"my","hp")
				game:gain(card,"my","hp")
			end
		else
			game:gain(card,"my","hp") 
		end
	end,

	onTurnStart = function(card,game,from)
		for i = 1, card.charge do
			game:attack(card,"self")
			game:gain(card,"my","magic")
		end
	end,

}

return data