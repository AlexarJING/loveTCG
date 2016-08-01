local data = {
	id = "charlatan",
	name = "Charlatan",
	faction = "metris",
	category = "underlings",
	rare = 4 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 4,
	hp = 1,
	last = true,
	charge = 0,
	canFeedGold=true
}

data.description = {
	"On turn/feed gold: +1 charge",
	"3 charges: restock from foe",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) 
		card.charge = card.charge + 1
		card:updateCanvas()
		if card.charge>= card.chargeMax then
			card.ability.onFullCharge(card,game)
		end
	end,
	onFeed = function (card,game) 
		card.charge = card.charge + 1
		card:updateCanvas()
		if card.charge>= card.chargeMax then
			card.ability.onFullCharge(card,game)
		end
	end,
	onFullCharge = function (card,game) 
		card.charge = 0
		game:refill("your")
		card:updateCanvas()
	end,

	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data