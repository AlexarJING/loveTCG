local data = {
	img_name = "bodyguard",
	name = "Bodyguard",
	faction = "metris",
	category = "underlings",
	rare = 3 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 5,
	hp = 4,
	last = true,
	intercept = true
}

data.description = {
	"Intercepts",
	"50%: destroy when killed ",
}

data.ability={
	onDestroyed = function (card,game) if game.rnd:random()<0.5 then return true end end
}

return data