local data = {
	id = "tomeofmemory",
	name = "Tome of Memory",
	faction = "endazu",
	category = "inscriptions",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 0,
	chargeMax = 20,
	last = true,
	awaken = false,
	canFeedMagic = true,
}

data.description = {
	"0/20 charge",
 	"Foe or ally dies: +1 charge",
 	"feed magic: all charge turn to magic",
}

data.ability={
	onAllyDie = function(card,game,dead)
		game:chargeCard(card)
	end,
	onFoeDie = function(card,game,dead)
		game:chargeCard(card)
	end,
	onFeed = function(card,game)
		card.awaken=nil
		for i = 1, card.charge do
			game:gain(card,"my","magic")
		end
	end
}

return data