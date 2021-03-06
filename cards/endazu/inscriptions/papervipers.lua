local data = {
	img_name = "paperviper",
	name = "Paper Vipers",
	faction = "endazu",
	category = "inscriptions",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 3,
	chargeMax = 20,
	last = true,
	foodType = "magic",
}

data.description = {
	"3/20 charge",
 	"For each charge: Retaliate",
 	"Feed magic: Convert charge into attacks "
}

data.ability={
	onFoeAttack = function(card,game,from)
		game:dischargeCard(card)
		game:attack(card)
	end,
	onFeed = function(card,game)
		for  i = 1, card.charge do
			game:dischargeCard(card)
			game:attack(card)
		end
	end
}

return data