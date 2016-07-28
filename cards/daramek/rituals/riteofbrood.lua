local data = {
	id = "riteofbrood",
	name = "Rite of Brood",
	faction = "daramek",
	category = "rituals",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
	last = 1
}

data.description = {
	"Until end of turn:",
	"For each card played",
	"+ resource"
}

data.ability={
	onPlay = function (card,game)
		card.currentCardPlayed = game.cardPlayCount
	end,
	always = function (card,game)
		if game.cardPlayCount> card.currentCardPlayed then
			for i = 1, game.cardPlayCount-card.currentCardPlayed do
				game:gain(card,"my","random")
			end
			card.currentCardPlayed = game.cardPlayCount
		end
	end,
}

return data