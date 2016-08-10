local data = {
	img_name = "toady",
	name = "Lackey",
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
		
		card.ability = card.data.ability

		delay:new(0.01,nil,function() 
			game:refillCard("my",function(cards)
				local candidate = {}
				local index = 0
				for k,v in pairs(cards.metris.underlings) do
					index = index + 1
					candidate[index] = v
				end
				return table.random(candidate)
			end,card.level) 
		end)
		
		card.ability = {}
		
		for k,v in pairs(game.my.hero.card.ability) do
			card.ability[k]=v
		end
	end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data