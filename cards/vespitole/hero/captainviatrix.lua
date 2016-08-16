local data = {
	img_name = "captainviatrix",
	name = "Captain Listrata",
	name_cn = "丽丝莱塔船长",
	faction= "vespitole",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 1,
	hp = 30
}

data.description = {
	"turn: +1 food",
}

data.description_cn = {
	"每回合：+1 食物"
}

data.ability={
	onTurnStart = function(card,game) 
		game:gain(card,"my","food")
	end,
}

return data