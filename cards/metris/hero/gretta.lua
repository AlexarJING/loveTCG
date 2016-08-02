local data = {
	id = "gretta",
	name = "Gretta",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = "E",
	hp = 30
}

data.description = {
	"Intercept 25% of attacks.",
 	"When attacked: 20%: retaliate"
}

data.ability={
	onFoeAttack = function(card,game,target)
		if love.math.random()<0.25 then
			return card
		end
	end,

	onAttacked = function (card,gamem,from)
		game:attack(card,from)
	end
}

return data