local data = {
	img_name = "brute",
	name = "Brute",
	faction = "metris",
	category = "underlings",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 6,
	hp = 3,
	last = true,
}

data.description = {
	"On turn: Attack x2",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) game:attack(card);game:attack(card) end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data