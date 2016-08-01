local data = {
	id = "apothecary",
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
		game:refill("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.poison then
					table.insert(candidate, v)
				end
			end
			if not candidate[1] then return end
			return table.random(candidate)
		end) 
	end,
	onTurnStart = function (card,game)
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then 
				v.hp = v.hp_max
				v:updateCanvas()
			end	
		end 

	end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data