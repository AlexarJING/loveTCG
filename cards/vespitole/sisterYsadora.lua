local data = {
	id = "sisterysadora",
	name = "sister ysadora",
	faction= "vespitole",

	profile = {"Men will always fight harder for a lord with battle scars. "},

	isHero = true,

}

data.description = {
	"attack: 75% heal",
}

data.ability={
	onAttack = function(card,game) 
		if love.math.random()<0.75 then
			game.me.resource.hp = game.me.resource.hp + 1
		end
	end,
}

return data