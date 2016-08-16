local data = {
	img_name = "benediction",
	name = "Benediction",
	faction = "vespitole",

	category = "faith",
	rare = 3 ,

	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},

	basePrice = 11,
	
	back = true,
}

data.description = {
	"play: activate all allies",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game)
		game:drawCard()
		game:activateCard(card,"all",true)
	end,

}

return data