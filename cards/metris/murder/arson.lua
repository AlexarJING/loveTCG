local data = {
	id = "arson",
	name = "Arson",
	faction = "metris",
	category = "murder",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 7,
}

data.description = {
	"Foe loses 7 resources",
 	"Attack for 7 minus each lost",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)		
		for i = 1, 7 do
			if not game:lose(card,"your","random") then
				game:attack(card)
			end
		end
	end,
}

return data