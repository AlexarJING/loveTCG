local data = {
	id = "satchelbomb",
	name = "Satchel Bomb",
	faction = "metris",
	category = "murder",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 6,
	last = 3,
	bomb = true
}

data.description = {
	"In 2 turns: attack x6",
 	"Destroy after use",
}

data.ability={
	onKilled = function(card,game)			
		for i = 1, 6 do
			game:attack(card)
		end	
	end,
}

return data