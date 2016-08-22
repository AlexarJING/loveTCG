local data = {
	img_name = "backercoin",
	name = "Kongregate",
	faction = "coins",
	--category = "coin",
	rare = "E" ,

	profile = {"no money, you can do nothing!"},

	back = true,
	isCoin = true,
}

data.description = {
	"play: +1 gold",
	"random coin effect"
}

data.ability={
	onPlay = function(card,game)
		local coins = {}

		for k,v in pairs(game.cardData.coins) do
			table.insert(coins,v)
		end
		local cardData = game.rnd:table(coins)
		cardData.ability.onPlay(card,game)
	end,
}

return data