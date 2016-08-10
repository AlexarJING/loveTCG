local data = {
	img_name = "embezzlement",
	name = "Embezzle",
	faction = "metris",
	category = "espionage",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
	last = 4
}

data.description = {
 	"turn: Steal 1 resource",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)
		game:steal(card,"random")
	end,
}

return data