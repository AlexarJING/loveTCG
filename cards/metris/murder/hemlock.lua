local data = {
	id = "belledonna",
	name = "Belledonna",
	faction = "metris",
	category = "murder",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 9,
	last = 6,
	poison = true
}

data.description = {
	"On turn: Attack hero x2",
 	"Ignores intercept",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)		
		game:attack(card,"hero",true)
		game:attack(card,"hero",true)
	end,
}

return data