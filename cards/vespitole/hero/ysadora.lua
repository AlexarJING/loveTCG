local data = {
	id = "ysadora",
	name = "sister ysadora",
	faction= "vespitole",

	profile = {"Men will always fight harder for a lord with battle scars. "},

	isHero = true,
	rare = 3,
}

data.description = {
	"attack: 75% heal",
}

data.ability={
	onAttack = function(card,game) 
		if love.math.random()<0.75 then
			game.my.resource.hp = game.my.resource.hp + 1
		end
	end,
}

return data