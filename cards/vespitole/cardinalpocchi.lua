local data = {
	id = "cardinalpocchi",
	name = "cardinal pocchi",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,

}

data.description = {
	"turn: +1 gold",
}

data.ability={
	
	onTurnStart = function(card,game) 
		game:gain(card,"my","gold",1)
	end,
}

return data