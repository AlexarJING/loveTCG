local data = {
	img_name = "orphangang",
	name = "Orphan Gang",
	faction = "daramek",
	category = "slaves",
	rare = 1 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 4,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"On turn/feed/play",
	"attack weakest",
}



data.ability={
	onTurnStart = function (card,game) 
		game:attack(card,"weakest")		--card,who,what
	end,
	onPlay = function (card,game)
		game:attack(card,"weakest")
	end,
	onFeed = function (card,game)
		game:attack(card,"weakest")
	end,
}

return data