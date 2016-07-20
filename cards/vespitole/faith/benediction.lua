local data = {
	id = "benediction",
	name = "Benediction",
	faction = "vespitole",

	category = "prosperity",
	rare = 3 ,

	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},

	basePrice = 11,
	
	back = true,
}

data.description = {
	"play: activate all allies",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game)
		game:drawCard()
		if game.my.hero.card.ability.onTurnStart then
			game.my.hero.card.ability.onTurnStart(game.my.hero.card,game)
		end
		for i,v in ipairs(game.my.play.cards) do
			if v.ability.onTurnStart then
				v.ability.onTurnStart(v,game)
			end
		end
	end,

}

return data