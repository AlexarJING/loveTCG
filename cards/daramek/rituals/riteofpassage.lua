local data = {
	id = "riteofpassage",
	name = "Rite of Passage",
	faction = "daramek",
	category = "rituals",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 10,
	back = true,
	last = 1
}

data.description = {
	"Until end of turn:",
	"For each card played",
	"feed hero with magic"
}

data.ability={
	onCardPlay = function (card,game)
		game:feedHeroWith("magic")
	end,
}

return data
