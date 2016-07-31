local data = {
	id = "misdirect",
	name = "Misdirect",
	faction = "metris",
	category = "conspiracy",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
	intercept = true,
	shield = 2,
}

data.description = {
	"Intercept 2 attacks",
 	"Rediect attack to foe",
 	"Destroy after use ",
}

data.ability={
	onAttacked = function(card,game,from)		
		game:attack(card,from)
	end,
}

return data