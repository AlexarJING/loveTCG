local data = {
	img_name = "foolsgeld",
	name = "Fool's Geld",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"20% change: foe -1 resource"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.2 then
			game:lose(card,"your","random")
		end
	end,
}

return data