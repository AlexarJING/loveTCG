local data = {
	img_name = "sacrificiallamb",
	name = "Sacrificial Lamb",
	faction = "daramek",
	category = "slaves",
	rare = "H" ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 3,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"Always sacrificed first.",
 	"When sacrificed:",
 	"+1 resources",
 	"feed hero magic ",
}

data.ability={
	onSacrifice = function(card,game)
		game:gain(card,"my","random")
		game:feedCard(game.my.hero.card,false,"magic")
	end
}

return data