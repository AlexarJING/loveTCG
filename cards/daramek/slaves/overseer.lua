local data = {
	id = "overseer",
	name = "Overseer",
	faction = "daramek",
	category = "slaves",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"When play an ally",
	"Activate that ally",
}

data.ability={
	onPlay = function (card,game)
		card.currentCardPlayed = game.cardPlayCount
	end,
	onTurnStart = function (card,game)
		card.currentCardPlayed = game.cardPlayCount
	end,
	always = function (card,game)
		if card.current.root ~= game.turn then return end
		if game.cardPlayCount> card.currentCardPlayed then
			local ab = game.lastPlayed.ability.onTurnStart
			if ab then
				ab(game.lastPlayed,game)
			end
		end
	end,
	
}

return data