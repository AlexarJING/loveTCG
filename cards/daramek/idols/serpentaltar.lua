local data = {
	img_name = "serpentinealter",
	name = "Serpent Altar",
	faction = "daramek",
	category = "idols",
	rare = 2 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 5,
	last = true,
	back = true,
}

data.description = {
	"When your hero attacks",
	"25% chance: attack",
}

data.ability={
	onAllyAttack = function(card,game,who)
		if who == game.my.hero.card then 
			if love.math.random()<0.25 then game:attack(card) end
		end
	end,
}

return data