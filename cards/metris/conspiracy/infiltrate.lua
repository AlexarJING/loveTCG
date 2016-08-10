local data = {
	img_name = "infiltrate",
	name = "Infiltrate",
	faction = "metris",
	category = "conspiracy",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 10,
	last = true,
}

data.description = {
	"each turn: ",
	"Draw a card from foe",
}

data.ability={
	onTurnStart= function(card,game)
		game:drawCard("your")
	end
}

return data