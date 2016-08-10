local data = {
	img_name = "frame",
	name = "Frame",
	faction = "metris",
	category = "conspiracy",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 8,
	intercept = true,
	charge = 5,
	last = true
}

data.description = {
	"Intercept 5 attacks",
 	"Redirect attack to foe",
 	"Destroy after use ",
}

data.ability={
	onAttacked = function(card,game,from)		
		game:attack(card)
	end,
}

return data