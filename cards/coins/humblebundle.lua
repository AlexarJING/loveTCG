local data = {
	img_name = "humblecoin",
	name = "Humble Bundle",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"10% change: summon Cattle"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.1 then
			game:summon(card,"cattle")
		end
	end,
}

return data