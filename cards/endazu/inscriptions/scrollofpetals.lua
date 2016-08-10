local data = {
	img_name = "scrollofpetals",
	name = "Scroll of Petals",
	faction = "endazu",
	category = "inscriptions",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 3,
	chargeMax = 20,
	last = true,
	canFeedMagic = true,
}

data.description = {
	"3/20 charge",
 	"turn: -1 charge, +1 magic",
 	"feed magic: convert all charge to magic",
}

data.ability={
	onTurnStart = function (card,game)
		game:dischargeCard(card)
		game:gain(card,"my","magic")
	end,
	onFeed = function(card,game)
		for i = 1, self.charge do
			game:gain(card,"my","magic")
			game:dischargeCard(card)
		end
			
	end
}

return data