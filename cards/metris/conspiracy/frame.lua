local data = {
	id = "frame",
	name = "Frame",
	faction = "metris",
	category = "conspiracy",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 8,
	intercept = true,
	shield = 5,
}

data.description = {
	"Intercept 5 attacks",
 	"Rediect attack to foe",
 	"Destroy after use ",
}

data.ability={
	onAttacked = function(card,game,from)		
		game:attack(card,from)
	end,
}

return data