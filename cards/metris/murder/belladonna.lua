local data = {
	id = "belladonna",
	name = "Belladonna",
	faction = "metris",
	category = "murder",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 5,
	last = 6,
	poison = true
}

data.description = {
	"On turn: Attack hero",
 	"Ignores intercept",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)		
		game:attack(card,"hero",true)
	end,
}

return data