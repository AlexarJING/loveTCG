local data = {
	img_name = "orom",
	name = "Orom",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 4,
	hp = 30
}

data.description = {
	"On sacrifice ally:",
	"+1 random resource",
}

data.ability={
	onSacrificeAlly = function(card,game,target)
		game:gain(target,"my","random")
	end
}

return data