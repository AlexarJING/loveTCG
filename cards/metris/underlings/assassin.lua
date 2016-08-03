local data = {
	id = "assassin",
	name = "Assassin",
	faction = "metris",
	category = "underlings",
	rare = 3 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 4,
	hp = 2,
	last = true,
}

data.description = {
	"On Gain Skull: attack weakest",
	"On turn: attack weakest",
	"50%: destroy when killed ",
}

data.ability={
	onGain = function (card,game,who,what)  --card.ability.onGain(card,self,who,what)
		if what == "skull" then
			game:attack(card,"weakest")
		end
	end,
	onTurnStart = function (card,game) game:drawCard("your") end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data