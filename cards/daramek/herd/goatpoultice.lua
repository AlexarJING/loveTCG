local data = {
	img_name = "goatpoultice",
	name = "Goat Poultice",
	faction = "daramek",
	category = "herd",
	rare = 3 ,
	profile = {"Gather the coarse, waxy hairs from adult males. The more the better. Soak them in an open basket with water and finch weed. They will swell and yellow until a jelly forms that must be collected with the shell of a hess beetle.–Esra"},
	basePrice = 4,
	back = true,
}

data.description = {
	"Restock Herd of Goats.",
 	"Draw Herd of Goats",
 	"Activate all goats", 
}

data.ability={
	onPlay = function (card,game) 
		game:refillCard("my","herdofgoats",card.level)
		game:drawCard("my","herdofgoats",_,card.level)
		game:activateCard(card,"herdofgoats")
	end,
}

return data