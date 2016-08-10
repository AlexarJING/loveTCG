local data = {
	img_name = "holywrath",
	name = "Holy Wrath",
	faction = "vespitole",

	category = "faith",
	rare = 4 ,

	profile = {"The philosophers can go debate justice until the sun burns to embers, for I am blessed by God and will bring calamity down on all who oppose me. –Cardinal Pocchi"},

	basePrice = 14,
	back = true,
}

data.description = {
	"for each magic attack",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i= 1, game.my.resource.magic do
			game:attack(card)
		end
	end,
	
}

return data