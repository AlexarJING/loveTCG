local data = {
	id = "festival",
	name = "Festival",
	faction = "daramek",
	category = "rituals",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
}

data.description = {
	"Sacrifice weakest ally",
	"Draw a ritual",
	"Restock a ritual"
}

data.ability={
	onPlay = function (card,game)
		local sacrificed = game:sacrificeCard("weakest")
		if not sacrificed then return end
		game:drawCard("my",
			function(cards) 
				local candidate = {}
				for i,v in ipairs(cards) do
					if v.category == "ritual" and v.id~="festival" then
						table.insert(candidate, v)
					end
				end
				if not candidate[1] then return end
				return candidate[love.math.random(#candidate)]
			end
		)
		game:refillCard("my",function(cards) 
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.category == "ritual" and v.id~="festival" then
					table.insert(candidate, v)
				end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
	end,
}

return data