local data = {
	img_name = "bounty",
	name = "bounty",
	faction = "vespitole",
	category = "power",
	rare = 2 ,

	profile = {"Gold is power. Anyone who disagrees possesses neither.	-Captain Listrata"},


	basePrice = 9,


	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: each gold attack",
	"play: lose all gold",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i= 1, game.my.resource.gold do  
			game:lose(card,"my","gold")
			game:attack()
		end
	end,
}

return data