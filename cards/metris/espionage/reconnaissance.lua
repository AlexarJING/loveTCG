local data = {
	img_name = "reconnaissance",
	name = "Reconnaissance",
	faction = "metris",
	category = "espionage",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 7,
	last = 3
}

data.description = {
 	"turn: +2 skull",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)
		game:gain(card,"my","skull")
		game:gain(card,"my","skull")
	end,
}

return data