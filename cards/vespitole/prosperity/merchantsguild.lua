local data = {
	img_name = "merchantsguild",
	name = "Merchant Guild",
	faction = "vespitole",
	category = "prosperity",
	rare = "H" ,

	profile = {"I claim no nation, I follow no gods. Commerce is my worship and gold is my prayer. –-Guildmaster Nevretto"},

	basePrice = 13,


	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +1 food",
	"each food +1 gold",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		game:gain(card,"my","food")
		for i= 1, game.my.resource.food do  
			game:gain(card,"my","gold")
		end
	end,
}

return data