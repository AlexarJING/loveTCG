local data = {
	id = "deceit",
	name = "Deceit",
	faction = "metris",
	category = "conspiracy",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 2,
}

data.description = {
	"Draw 2 cards from foe",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)		
		game:drawCard("your")
		game:drawCard("your")
	end,
}

return data