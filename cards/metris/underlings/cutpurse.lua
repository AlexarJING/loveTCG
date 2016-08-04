local data = {
	id = "cutpurse",
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
		if game:lose(card,"your","random") then
			game:gain(card,"my",res) 
		end
	end,
	--onFoeGain(card,self,who,what)
	onFoeGain = function (card,game,who,what) 
		if love.math.random()<0.05 then
			game:gain(card,"your",what)
			game:gain(card,"my",what)
		end
	end,

	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data