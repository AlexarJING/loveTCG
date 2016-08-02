local data = {
	id = "mogesh",
	name = "Mogesh",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 4,
	hp = 30
}

data.description = {
	"When Feed Magic: ",
	"Sacrifice strongest ally:",
	"Attack for victim's life ",
}

data.ability={
	onFeedMagic = function(card,game)
		local victim = game:sacrificeCard("strongest")
		if not victim then return end
		for i = 1,victim.hp do
			game:attack()
		end
	end
}

return data