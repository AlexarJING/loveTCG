local data = {
	img_name = "enchantedtreaty",
	name = "Enchanted Treaty",
	faction = "endazu",
	category = "inscriptions",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 3,
	chargeMax = 6,
	last = true,
	foodType = "magic"
}

data.description = {
	"3/6 charge",
 	"turn: -1 charge, heal foe, +1 magic",
 	"feed magic: +3 charge",
}

data.ability={
	onTurnStart = function (card,game)
		game:dischargeCard(card)
		for i,v in ipairs(game.your.play.cards) do
			game:healCard(v)
		end
		game:gain(card,"my","magic")
	end,
	onFeed = function(card,game)
		for i = 1, 3 do
			game:chargeCard(card)
		end	
	end,
}

return data