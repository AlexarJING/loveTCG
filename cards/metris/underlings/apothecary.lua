local data = {
	img_name = "apothecary",
	name = "Apothecary",
	faction = "metris",
	category = "underlings",
	rare = 4 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 3,
	hp = 1,
	last = true,
	canFeedGold = true
}

data.description = {
	"On feed coin: restock poison.",
 	"On turn: fully heal allies",
	"50%: destroy when killed ",
}

data.ability={
	onFeed = function (card,game) 
		
		local poisons = {"belladonna", "hemlock" , "arsenic"}
		print(table.random(poisons))
		game:refillCard("my",table.random(poisons))

	end,
	onTurnStart = function (card,game)
		game:healCard("all",true)
	end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data