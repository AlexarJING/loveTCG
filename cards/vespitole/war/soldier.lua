local data = {
	img_name = "soldier",
	name = "Soldier",
	faction = "vespitole",
	category = "war",
	rare = 3 ,
	profile = {"Some were born to craft songs, and some to craft prayers. Some were born to craft fine works of art. I was born to craft death, and your army will be my masterpiece. –Brynne Galli"},
	basePrice = 10,
	hp = 3,
	intercept = true,
	last = true,
	back = true,
}

data.description = {
	"intercept,75% retaliate",
	"play: draw a card",
	"turn/feed: attack",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) game:attack(card)end,
	onFeed = function (card,game) game:attack(card) end,
	onAttacked = function(card,game,from) if love.math.random()<0.75 then game:attack(card) end end
}

return data