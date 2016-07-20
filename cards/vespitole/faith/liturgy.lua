local data = {
	id = "liturgy",
	name = "Liturgy",
	faction = "vespitole",

	category = "faith",
	rare = 4 ,

	profile = {"Let them deafen the Pendrach with misguided praise. Their feeble minds cannot fathom the power they give me. –Cardinal Pocchi"},

	basePrice = 11,
	back = true,
}

data.description = {
	"for each ally +1 magic",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then game:gain(v,"my","magic") end
		end
	end,
	
}

return data