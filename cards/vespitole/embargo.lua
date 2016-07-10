local data = {
	id = "embargo",
	name = "embargo",
	faction = "vespitole",
	category = "power",
	rare = 1 ,

	profile = {"No merchant will accept your gold. No ports will harbor your ships. When your people rise against you, you will curse my name to the heavens and the heavens will side with me. –Captain Listrata"},


	basePrice = 6,


	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: foe -1 resource"
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		game:lose(card,"your","random")
	end,
}

return data