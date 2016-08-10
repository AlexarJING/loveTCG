local data = {
	img_name = "overseer",
	name = "Overseer",
	faction = "daramek",
	category = "slaves",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 6,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"When play an ally",
	"Activate that ally",
}

data.ability={
	onCardPlay = function (card,game,target)
		game:activateCard(card,target)
	end,
}

return data