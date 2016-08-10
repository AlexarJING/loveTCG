local data = {
	img_name = "ratcatcher",
	name = "Rat Catcher",
	faction = "daramek",
	category = "slaves",
	rare = 2 ,
	profile = {"Big rats, small rats, rats with horns, rats with no legs. Fighting rats, talking rats, they all fit in my cage. " },
	basePrice = 6,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"On turn/play",
	"draw ally",
}

data.ability={
	onTurnStart = function (card,game) 
		game:drawCard("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.hp and v.id~="ratcatcher" then
					table.insert(candidate,v)
				end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
	end,
	onPlay = function (card,game)
		game:drawCard("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.hp and v.id~="ratcatcher" then
					table.insert(candidate,v)
				end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
	end,
}

return data