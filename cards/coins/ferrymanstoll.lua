local data = {
	id = "ferrymanstoll",
	name = "Ferryman's Toll",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"20% change: +1 skull"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.2 then
			game:gain(card,"my","skull")
		end
	end,
}

return data