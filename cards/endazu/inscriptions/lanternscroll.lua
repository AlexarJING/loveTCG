local data = {
	img_name = "writofrecovery",
	name = "Latern Scroll",
	faction = "endazu",
	category = "inscriptions",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 3,
	chargeMax = 5,
	last = true,
	canFeedMagic = true,
}

data.description = {
	"3/5 charge",
 	"turn/feed magic: -1 charge",
 	"heal hero x2 "
}

data.ability={
	onTurnStart = function(card,game)
		game:dischargeCard(card)
		game:healCard(game.my.hero.card)
		game:healCard(game.my.hero.card)
	end,
	onFeed = function(card,game)
		game:dischargeCard(card)
		game:healCard(game.my.hero.card)
		game:healCard(game.my.hero.card)
	end
}

return data