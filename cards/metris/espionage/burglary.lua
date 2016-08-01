local data = {
	id = "burglary",
	name = "Burglary",
	faction = "metris",
	category = "espionage",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 7,
}

data.description = {
	"Steal the cheapest card",
	"from your foe's bank",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		game.my.canRob = true
	end,
}

return data