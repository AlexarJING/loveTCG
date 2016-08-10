local data = {
	img_name = "satchelbomb",
	name = "Satchel Bomb",
	faction = "metris",
	category = "murder",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 6,
	timer = 2,
	bomb = true
}

data.description = {
	"In 2 turns: attack x6",
 	"Destroy after use",
}

data.ability={
	onTimeUp = function(card,game)			
		for i = 1, 6 do
			game:attack(card)
		end	
	end,
}

return data