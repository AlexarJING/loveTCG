local data = {
	img_name = "madamaline",
	name = "Madam Aline",
	faction= "vespitole",

	profile = {"Torturers, soldiers, spies, and kings all spill fields of blood to wrench whispered half truths from their victims. Ours lay bare their every secret without a drop spilt. –Madam Aline"},

	isHero = true,
	rare = 4,
	hp = 30
}

data.description = {
	"start with",
	"2 courtesan",
}

data.ability={
	
	onTurnStart = function(card,game) 
		if game.turnCount <= 2 then
			game:summon(card,"courtesan")
			game:summon(card,"courtesan")
		end
	end,
}

return data