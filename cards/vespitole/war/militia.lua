local data = {
	img_name = "militia",
	name = "Militia",
	faction = "vespitole",
	category = "war",
	rare = 1 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 5,
	hp = 1,
	intercept = true,
	last = true,
	back = true,
}

data.description = {
	"intercept,25% retaliate",
	"play: draw a card",
	"turn/feed: attack",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card)end,
	onFeed = function (card,game) game:attack(card) end,
	onAttacked = function(card,game,from) if love.math.random()<0.25 then game:attack(card) end end
}

return data