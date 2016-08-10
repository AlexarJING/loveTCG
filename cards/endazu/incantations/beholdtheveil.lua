local data = {
	img_name = "beholdtheveil",
	name = "Behold the Veil",
	faction = "endazu",
	category = "incantations",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	--last = true,
	chargeInit = 1,
	chargeMax = 20
}

data.description = {
	"1/20 charge",
 	"On hold: +1 charge",
 	"On play: for each charge +1 magic",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		for i = 1, card.charge do
			game:gain(card,"my","magic")
		end
	end,
}

return data