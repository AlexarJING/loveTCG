local data = {
	id = "wishingcoin",
	name = "Wishing Coin",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"18% change: +1 magic"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.18 then
			game:gain(card,"my","magic")
		end
	end,
}

return data