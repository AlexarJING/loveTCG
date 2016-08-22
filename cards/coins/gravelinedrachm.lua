local data = {
	img_name = "squarecoin",
	name = "Graveline Drachm",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"8% change: restock Fire Ship"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if game.rnd:random()<0.08 then
			game:refill("my","fireship")
		end
	end,
}

return data