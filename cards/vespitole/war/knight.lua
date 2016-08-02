local data = {
	id = "knight",
	name = "Knight",
	faction = "vespitole",
	category = "war",
	rare = 4 ,
	profile = {" have spent more time in armor than most have spent awake. My skin is metal, my legs: a horse, and my arm a vengeful sword, honed on bones of weaker men. –Sir Mathias"},
	basePrice = 12,
	hp = 4,
	intercept = true,
	last = true,
	back = true,
}

data.description = {
	"intercept, retaliate",
	"play: draw a card",
	"turn/feed: attack",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card)end,
	onFeed = function (card,game) game:attack(card) end,
	onAttacked = function(card,game,from)  game:attack(card,from) end
}

return data