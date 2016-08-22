local data = {
	img_name = "knifecoin",
	name = "Wergeld Seax",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"15% change: summon berserker"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if game.rnd:random()<0.15 then
			game:summon(card,"berserker")
		end
	end,
}

return data