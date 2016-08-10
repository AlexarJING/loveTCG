local data = {
	img_name = "theodox",
	name = "Theodox",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 3,
	hp = 30
}

data.description = {
	"20% chance:", 
	"Prevent destruction",
}

data.ability={
	onDestroyCard = function (card,game,target)
		if  target.born == game.my  and love.math.random()<0.2 then
			return true
		end
	end
}

return data