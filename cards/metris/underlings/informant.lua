local data = {
	img_name = "informant",
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
		delay:new(0.01,nil,function() 
			game:refillCard("my",function(cards)
				local candidate = {}
				local index = 0
				for k,v in pairs(cards.metris.espionage) do
					index = index + 1
					candidate[index] = v
				end
				return table.random(candidate)
			end,card.level) 
		end)
	end,
	onTurnStart = function (card,game) game:drawCard("your") end,
	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data