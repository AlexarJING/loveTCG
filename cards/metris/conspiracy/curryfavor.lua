local data = {
	id = "curryfavors",
	name = "Curry Favor",
	faction = "metris",
	category = "conspiracy",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 2,
}

data.description = {
	"+3 food",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)		
		game:gain(card,"my","food")
		game:gain(card,"my","food")
		game:gain(card,"my","food")
	end,
}

return data