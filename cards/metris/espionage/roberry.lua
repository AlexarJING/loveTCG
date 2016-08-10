local data = {
	img_name = "robbery",
	name = "Robbery",
	faction = "metris",
	category = "espionage",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 3,
}

data.description = {
	"Steal 2 resources",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)		
		for i = 1, 2 do
			game:steal(card,"random")
		end
	end,
}

return data