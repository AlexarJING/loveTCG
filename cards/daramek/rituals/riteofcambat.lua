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
	onPlay = function (card,game)
		card.currentCardPlayed = game.cardPlayCount
	end,
	always = function (card,game)
		if card.current.root ~= game.turn then return end
		if game.cardPlayCount> card.currentCardPlayed then
			for i = 1, game.cardPlayCount-card.currentCardPlayed do
				game:attack(card)
			end
			card.currentCardPlayed = game.cardPlayCount
		end
	end,
}

return data