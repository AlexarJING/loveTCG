local data = {
	img_name = "swindlersmark",
	name = "Swindler's Mark",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"12% change: steal 1 resource"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.12 then
			game:steal(card,"random")
		end
	end,
}

return data