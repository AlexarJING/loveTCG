local data = {
	id = "tazin",
	name = "Tazin",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 4,
}

data.description = {
	"When an enemy attacks:",
	" 25% chance: retaliate ",
}

data.ability={
	onFoeAttack = function(card,game)
		if love.math.random()<0.25 then
			game:attack()
		end
	end
}

return data