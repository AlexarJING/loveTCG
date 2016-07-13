local data = {
	id = "courtesan",
	name = "courtesan",
	faction = "vespitole",

	category = "power",
	rare = 1 ,

	profile = {"You cannot whisper a sigh in your bedchambers without a Vespitole hearing about it. –Geofretto Piscez"},


	basePrice = 6,
	hp = 1,

	block = false,

	last = true,

	back = true,
}

data.description = {
	"turn/feed: +1 skull",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) game:gain(card,"my","skull") end,
	onFeed = function(card,game) game:gain(card,"my","skull") end,
}

return data