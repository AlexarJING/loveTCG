local data = {
	img_name = "prayer",
	name = "Prayer",
	faction = "vespitole",

	category = "faith",
	
	rare = 2 ,

	profile = {"Just as the wind can be harnessed to mill, so hath their prayers, bend to His will. –Inscription, Holy seat of Gallius"},


	basePrice = 7,

	back = true,
}

data.description = {
	"play: +1 magic",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","magic")
	end,
}

return data