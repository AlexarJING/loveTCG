local data = {
	img_name = "wargoats",
	name = "Goat Outrider",
	faction = "daramek",
	category = "herd",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 8,
	hp = 3,
	last = true,
	back = true,
	intercepts = true,
	dodgeRate = 0.5
}

data.description = {
	"Intercepts, retaliates.",
 	"Dodges 50% of attacks."
}

data.ability={
	onAttacked = function(card,game,from) 
		if game.rnd:random()<0.5 then game:attack(card) end 
	end
}

return data