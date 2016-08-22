local data = {
	img_name = "ysadora",
	name = "Sister Ysadora",
	faction= "vespitole",

	profile = {"Men will always fight harder for a lord with battle scars. "},

	isHero = true,
	rare = 3,
	hp = 30
}

data.description = {
	"attack: 75% heal",
}

data.ability={
	onAttack = function(card,game) 
		if game.rnd:random()<0.75 then
			game:healCard(card)
		end
	end,
}

return data