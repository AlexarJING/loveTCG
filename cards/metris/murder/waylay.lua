local data = {
	img_name = "waylay",
	name = "Waylay",
	faction = "metris",
	category = "murder",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,	
}

data.description = {
	"Attack weakest x3",
 	"Ignores intercept",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		for i = 1, 3 do
			game:attack(card,"weakest",true)
		end
	end,
}

return data