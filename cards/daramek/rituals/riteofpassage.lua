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
	onPlay = function (card,game)
		card.currentCardPlayed = game.cardPlayCount
	end,
	always = function (card,game)
		if card.current.root ~= game.turn then return end
		if game.cardPlayCount> card.currentCardPlayed then
			for i = 1, game.cardPlayCount-card.currentCardPlayed do
				game:feedHeroWith("magic")
			end
			card.currentCardPlayed = game.cardPlayCount
		end
	end,
}

return data