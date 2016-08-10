local data = {
	img_name = "championspaiza",
	name = "Champion's Paiza",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"10% change: restock any card"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.1 then
			game:refillCard("my","any")
		end
	end,
}

return data