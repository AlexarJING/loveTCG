local data = {
	id = "devotion",
	name = "devotion",
	faction = "vespitole",

	category = "faith",
	
	rare = 3 ,

	profile = {"Storms never sink their ships. Their enemies fall mysteriously ill. Every day, fortune graces them with opportunities that others may see once in their lives. For reasons I cannot fathom, God listens to House Vespitole.–Cardinal Sutto"},

	basePrice = 10,

	back = true,
}

data.description = {
	"play: +2 magic",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:gain(card,"my","magic")
		game:gain(card,"my","magic")
	end,
}

return data