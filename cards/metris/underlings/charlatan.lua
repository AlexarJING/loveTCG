local data = {
	img_name = "charlatan",
	name = "Charlatan",
	faction = "metris",
	category = "underlings",
	rare = 4 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 4,
	hp = 1,
	last = true,
	charge = 0,
	chargeMax = 3,
	foodType = "gold"
}

data.description = {
	"On turn/feed gold: +1 charge",
	"3 charges: restock from foe",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) 
		game:chargeCard(card)
	end,
	onFeed = function (card,game) 
		game:chargeCard(card)
	end,
	onFullCharge = function (card,game) 
		print(card.charge)
		card.charge = 0
		game:refillCard("your")
		card:updateCanvas()
	end,

	onDestroyed = function (card,game) if game.rnd:random()<0.5 then return true end end
}

return data