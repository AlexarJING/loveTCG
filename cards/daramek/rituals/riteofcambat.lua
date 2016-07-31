local data = {
	id = "riteofcombat",
	name = "Rite of Combat",
	faction = "daramek",
	category = "rituals",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	last = 1
}

data.description = {
	"Until end of turn:",
	"For each card played",
	"Attack"
}

data.ability={
	onCardPlay = function (card,game)
		game:attack(card)
	end,
}

return data