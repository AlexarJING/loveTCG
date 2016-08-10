local data = {
	img_name = "ambush",
	name = "Ambush",
	faction = "metris",
	category = "murder",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,	
}

data.description = {
	"Attack foe's hero x3",
 	"Ignores intercept",
 	"Destroy after use ",
}

data.ability={
	onPlay = function(card,game)
		for i = 1, 3 do
			game:attack(card,"hero",true)
		end
	end,
}

return data