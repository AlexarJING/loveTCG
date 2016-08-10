local data = {
	img_name = "underworldbarge",
	name = "Underworld Barge",
	faction = "endazu",
	category = "anima",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
	chargeInit = 2,
	chargeMax = 20,
	last = true,
	hp = 3,
}

data.description = {
	"2/20 charge",
 	"On turn, attack x2",
	"On discard, for each charge:",
	"Summon Gilded Warrior ",
}

data.ability={
	onTurnStart = function (card,game)
		game:attack(card)
		game:attack(card)
	end,

	onKilled = function (card,game)
		for i = 1, card.charge do
			game:summon("gildedwarriors")
		end
	end
}

return data