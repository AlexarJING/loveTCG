local data = {
	id = "synod",
	name = "Synod",
	faction = "vespitole",

	category = "faith",
	rare = 3 ,

	profile = {"The Cardinals gather around the Penderach's corpse staging elaborate rituals to trick each other into believing the Penderach somehow approves of their agenda. –Gostino, Camerlengo"},

	basePrice = 7,
	last = 3,
	back = true,
}

data.description = {
	"turn: each gold + gold",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		game:refill()
	end,
}

return data