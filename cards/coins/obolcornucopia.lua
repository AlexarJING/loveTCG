local data = {
	img_name = "obolcornucopia",
	name = "Obol Cornucopia",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"20% change: +1 food"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if game.rnd:random()<0.2 then
			game:gain(card,"my","food")
		end
	end,
}

return data