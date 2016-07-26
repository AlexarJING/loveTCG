local data = {
	id = "warrats",
	name = "War Rats",
	faction = "daramek",
	category = "herd",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 5,
	hp = 2,
	last = true,
	back = true,
}

data.description = {
	"turn: attack x2",
}

data.ability={
	onTurnStart = function (card,game) 
		game:attack()	--card,who,what
		game:attack()
	end,
}

return data