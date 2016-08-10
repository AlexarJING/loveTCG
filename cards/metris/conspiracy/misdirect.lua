local data = {
	img_name = "misdirect",
	name = "Misdirect",
	faction = "metris",
	category = "conspiracy",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
	intercept = true,
	charge = 2,
	last = true
}

data.description = {
	"Intercept 2 attacks",
 	"Rediect attack to foe",
 	"Destroy after use ",
}

data.ability={
	onAttacked = function(card,game,from)		
		game:attack(card)
	end,
}

return data