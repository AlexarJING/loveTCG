local data = {
	img_name = "vicardoubloon",
	name = "Vicar Doubloon",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"20% change: +1 gold"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.2 then
			game:gain(card,"my","gold")
		end
	end,
}

return data