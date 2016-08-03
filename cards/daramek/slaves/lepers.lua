local data = {
	id = "lepers",
	name = "Lepers",
	faction = "daramek",
	category = "slaves",
	rare = 1 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 4,
	hp = 3,
	last = true,
	back = true,
}

data.description = {
	"On attacked: Retaliate",
}

data.ability={
	onAttacked = function(card,game,from) 
		game:attack(card) 
	end
}

return data