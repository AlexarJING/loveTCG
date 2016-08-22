local data = {
	img_name = "gretta",
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
		if game.rnd:random()<0.25 then
			return card
		end
	end,

	onAttacked = function (card,gamem,from)
		if game.rnd:random()<0.2 then
			game:attack(card)
		end
	end
}

return data