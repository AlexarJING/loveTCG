local data = {
	id = "bodyguard",
	name = "Bodyguard",
	faction = "metris",
	category = "underlings",
	rare = 3 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 5,
	hp = 1,
	last = true,
}

data.description = {
	"On play: restock underling",
	"Duplicate hero's ability",
	"50%: destroy when killed ",
}

data.ability={
	onPlay = function (card,game) 
		game:refill("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.category == "underlings" then
					table.insert(candidate, v)
				end
			end
			if not candidate[1] then return end
			return table.random(candidate)
		end)
		card.ability = {}
		for k,v in pairs(game.my.hero.card.ability) do
			card.ability[k]=v
		end
	end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data