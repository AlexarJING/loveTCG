local data = {
	img_name = "wagonbomb",
	name = "Wagon Bomb",
	faction = "metris",
	category = "murder",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 14,
	timer = 3,
	bomb = true
}

data.description = {
	"In 3 turns: attack x16",
 	"Destroy after use",
}

data.ability={
	onTimeUp = function(card,game)			
		for i = 1, 16 do
			game:attack(card)
		end

	end,
}

return data