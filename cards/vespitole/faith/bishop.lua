local data = {
	img_name = "bishop",
	name = "Bishop",
	faction = "vespitole",
	category = "faith",
	rare = 4 ,
	profile = {"Your family has done much for his church, I believe God owes you a favor. –Bishop Berto"},

	basePrice = 10,
	hp = 3,

	intercept = false,

	last = true,

	back = true,
}

data.description = {
	"turn: +1 each resource",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:gain(card,"my","food")
		game:gain(card,"my","gold") 
		game:gain(card,"my","magic") 
		game:gain(card,"my","skull") 
	end,
}

return data