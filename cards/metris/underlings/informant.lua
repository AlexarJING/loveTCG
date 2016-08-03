local data = {
	id = "informant",
	name = "Informant",
	faction = "metris",
	category = "underlings",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 4,
	hp = 1,
	last = true,
}

data.description = {
	"On buy: restock espionage",
	"On turn: Draw from foe",
	"50%: destroy when killed ",
}


data.ability={
	onBuy = function (card,game) 
		game:refill("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.category == "espionage" then
					table.insert(candidate, v)
				end
			end
			if not candidate[1] then return end
			return table.random(candidate)
		end) 
	end,
	onTurnStart = function (card,game) game:drawCard("your") end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data