local data = {
	id = "daramekcoin",
	name = "coin",
	faction = "daramek",
	--category = "coin",
	rare = 0 ,

	profile = {"no money, you can do nothing!"},


	back = true,

	isCoin = true,
}

data.description = {
	"play: +1 gold",
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold",1)
	end,
}

return data