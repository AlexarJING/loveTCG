local data = {
	img_name = "tazin",
	name = "Tazin",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 4,
	hp = 30
}

data.description = {
	"When an enemy attacks:",
	" 25% chance: retaliate ",
}

data.ability={
	onFoeAttack = function(card,game)
		if game.rnd:random()<0.25 then
			game:attack(card)
		end
	end
}

return data