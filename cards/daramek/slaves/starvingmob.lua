local data = {
	id = "starvingmob",
	name = "Starving Mob",
	faction = "daramek",
	category = "slaves",
	rare = 1 ,
	profile = {"An empty belly growls louder than any war drum. –Mogesh" },
	basePrice = 4,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"On turn/feed/play",
	"foe -1 resource",
}

data.ability={
	onTurnStart = function (card,game) 
		game:lose(card,"your","random")		--card,who,what
	end,
	onPlay = function (card,game)
		game:lose(card,"your","random")
	end,
	onFeed = function (card,game)
		game:lose(card,"your","random")
	end,
}

return data