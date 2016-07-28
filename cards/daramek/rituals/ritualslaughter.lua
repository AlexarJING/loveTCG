local data = {
	id = "ritualslaughter",
	name = "Ritual Slaughter",
	faction = "daramek",
	category = "rituals",
	rare = 1 ,
	profile = {" Find a pregnant sow. Have a dozen men scream at her until she is forced into early birth. Ferment each suckling in separate leather sacks, inscribed with the symbols 'haf', 'lem', 'peth', and 'kos'.  –Esra"},
	basePrice = 4,
	back = true,
}

data.description = {
	"Pick an ally to sacrifice",
 	"Gain random resources",
 	"equal to victim's life +1."
}

data.ability={
	onPlay = function (card,game)
		local candidate = {}
		for i,v in ipairs(game.my.play.cards) do
			if v.hp>0 and not v.cannotScrifice then
				table.insert(candidate, v)
			end
		end
		if not candidate[1] then return end
		game:optionsCards(candidate)
		game.show.onChoose = function(card,game)
			for i = 1, card.hp+1 do
				delay:new((i-1)*0.2,nil,game.gain,game,card,"my","random")
			end
			game:sacrificeCard(card)
		end
	end,
}

return data