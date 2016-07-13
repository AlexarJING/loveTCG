local data = {
	id = "loan",
	name = "loan",
	faction = "vespitole",
	category = "prosperity",
	rare = 2 ,

	profile = {"Wars are expensive. I'm sure we can find a solution that is in both of our best interests.–Ombreggiato Gritti"},



	basePrice = 5,


	last = 4,

	back = true,
}

data.description = {
	"play: draw a card",
	"gain 8 gold",
	"turn: pays 2 gold",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i = 1,8 do
			game:gain(card,"my","gold")
		end
	end,
	onTurnStart = function(card,game)
		for i = 1, 2 do
			game:lose(card,"my","gold")		
		end
	end
}

return data