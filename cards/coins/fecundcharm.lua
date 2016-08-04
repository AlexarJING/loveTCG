local data = {
	id = "fecundcharm",
	name = "Fecund Charm",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"12% change: summon flower"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.12 then
			game:summon("argorethflower")
		end
	end,
}

return data