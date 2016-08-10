local data = {
	img_name = "tithe",
	name = "Tithe",
	faction = "vespitole",

	category = "prosperity",
	
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
		local count =0

		for i,t in ipairs(game.your.play.cards) do
			if t.hp then count=count+1 end
		end
		for i = 1, count+1 do
			game:gain(v,"my","gold")
		end
		
	end,
}

return data