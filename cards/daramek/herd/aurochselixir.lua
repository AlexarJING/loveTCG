local data = {
	img_name = "oxelixir",
	name = "Aurochs Elixir",
	faction = "daramek",
	category = "herd",
	rare = 4 ,
	profile = {"Gather the coarse, waxy hairs from adult males. The more the better. Soak them in an open basket with water and finch weed. They will swell and yellow until a jelly forms that must be collected with the shell of a hess beetle.–Esra"},
	basePrice = 4,
	back = true,
}

data.description = {
	"Restock Herd of Aurochs",
	"Fully heal all allies.",
	"Activate all aurochs."
}

data.ability={
	onPlay = function (card,game) 
		game:refillCard("my","herdofaurochs",card.level)
		game:healCard("all",true)
		game:activateCard(card,"herdofaurochs")
		game:activateCard(card,"colossalaurochs")
	end,
}

return data