local data = {
	id = "robbery",
	name = "Robbery",
	faction = "metris",
	category = "espionage",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 2,
}

data.description = {
	"Attack",
 	"Foe loses 2 resources",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		game:attack(card)	
		for i = 1, 2 do
			game:lose(card,"your","random")
		end
	end,
}

return data