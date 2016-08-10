local data = {
	img_name = "miracle",
	name = "Miracle",
	faction = "vespitole",

	category = "faith",
	
	rare = 4 ,

	profile = {" It's not witchcraft when God does it. –Cardinal Pocchi"},

	basePrice = 13,

	back = true,
}

data.description = {
	"play: draw a random card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard("my","random") --whose,id
	end,
}

return data