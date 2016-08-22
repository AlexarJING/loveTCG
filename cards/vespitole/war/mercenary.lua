local data = {
	img_name = "mercenary",
	name = "Mercenary",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"A Mercenary is an Alchemist. He heats cold iron with hot blood, and from that crucible he pours gold. –Duchessa Cyneswith"},
	basePrice = 7,
	hp = 2,
	intercept = true,
	last = true,
	back = true,
}

data.description = {
	"intercept,50% retaliate",
	"play: draw a card",
	"turn/feed: attack",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card)end,
	onFeed = function (card,game) game:attack(card) end,
	onAttacked = function(card,game,from) if game.rnd:random()<0.50 then game:attack(card) end end
}

return data