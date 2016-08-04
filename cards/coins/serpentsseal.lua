local data = {
	id = "serpentsseal",
	name = "Serpent's Seal",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"24% change: feed hero magic"
}

data.ability={
	onPlay = function(card,game)
		game:gain(card,"my","gold")
		if love.math.random()<0.24 then
			game:feedCard(game.my.hero.card,nil,"magic") --game:feedCard(card,all,what)
		end
	end,
}

return data