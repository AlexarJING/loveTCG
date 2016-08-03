local data = {
	id = "surveil",
	name = "Surveil",
	faction = "metris",
	category = "espionage",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
	last = 3
}

data.description = {
 	"turn: +1 skull",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","skull")
	end,
}

return data