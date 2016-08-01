local data = {
	id = "loquori",
	name = "Loquori",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = "E",
}

data.description = {
	"When foe gains a resource",
 	"5% chance to steal it "
}

data.ability={
	onFoeGain = function (card,game,who,what) 
		if love.math.random()<0.05 then
			game:gain(card,"your",what)
			game:gain(card,"my",what)
		end
	end,
}

return data