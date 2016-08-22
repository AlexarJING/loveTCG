local data = {
	img_name = "cutpurse",
	name = "Cut Purse",
	faction = "metris",
	category = "underlings",
	rare = 4 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 4,
	hp = 1,
	last = true,
}

data.description = {
	"On turn: Steal 1 resource",
	"5%: steal gained resource",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) 
		game:steal(card,"random")
	end,

	onFoeGain = function (card,game,what) 

		if game.rnd:random()<0.05 then
			game:steal(card,what)
		end
	end,

	onDestroyed = function (card,game) if game.rnd:random()<0.5 then return true end end
}

return data