local data = {
	id = "subterfuge",
	name = "Subterfuge",
	faction = "metris",
	category = "conspiracy",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 6,
	last = 6
}

data.description = {
	"For 6 turns",
	"Draw a card from foe",
 	"Destroy after use ",
}

data.ability={
	onTurnStart = function(card,game)
		game:drawCard("your")
	end,
}

return data