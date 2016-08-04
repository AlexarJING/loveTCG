local data = {
	id = "bantlingcrown",
	name = "Bantling Crown",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"22% change: attack weakest"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.22 then
			game:attack(card,"weakest")
		end
	end,
}

return data