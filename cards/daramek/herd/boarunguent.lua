local data = {
	id = "boarunguent",
	name = "Boar Unguent",
	faction = "daramek",
	category = "herd",
	rare = 4 ,
	profile = {" Find a pregnant sow. Have a dozen men scream at her until she is forced into early birth. Ferment each suckling in separate leather sacks, inscribed with the symbols 'haf', 'lem', 'peth', and 'kos'.  –Esra"},
	basePrice = 4,
	--hp = 2,
	--last = true,
	back = true,
}

data.description = {
	"Restock Herd of Boars",
	"Activate all boars",
	"Feed hero magic" 
}

data.ability={
	onPlay = function (card,game) 
		game:refill("my","herdofboars",card)
		for i,v in ipairs(game.my.play.cards) do
			if v.id == "herdofgoats" or v.id == "direboar" then
				v.ability.onTurnStart(game,v)
			end
		end
		game:feedHeroWith("magic")
	end,
}

return data