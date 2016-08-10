local data = {
	img_name = "haltingrebuke",
	name = "Halting Rebuke",
	faction = "endazu",
	category = "incantations",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	last = true,
	chargeInit = 2,
	chargeMax = 10,
	intercept = true
}

data.description = {
	"2/10 charge",
 	"On hold: +2 charge",
 	"On play: for each charge intercept",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		card.shield = card.charge
	end,
}

return data