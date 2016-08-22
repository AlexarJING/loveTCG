local data = {
	img_name = "loquori",
	name = "Loquori",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = "E",
	hp = 30
}

data.description = {
	"When foe gains a resource",
 	"5% chance to steal it "
}

data.ability={
	onFoeGain = function (card,game,what) 
		if game.rnd:random()<0.05 then
			game:steal(card,what)
		end
	end,
}

return data