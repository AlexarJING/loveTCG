local data = {
	id = "tithe",
	name = "tithe",
	faction = "vespitole",

	category = "faith",
	
	rare = "H" ,

	profile = {" Of course all are beloved, both pauper and lord. Holy favor simply gazes more fondly upon gold, just as a flower follows the sun. –Cardinal Nicchi"},

	basePrice = 10,

	back = true,
}

data.description = {
	"for each ally +1 gold",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then game:gain(card,"my","gold") end
		end
	end,
}

return data