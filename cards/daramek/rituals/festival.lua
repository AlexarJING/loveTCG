local data = {
	img_name = "festival",
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
				return game.rnd:table(candidate)
			end
		)
		game:refillCard("my",function(cards) 
			local candidate = {}
			for k,v in pairs(cards.daramek.rituals) do
				if v.id~="festival" then
					table.insert(candidate, v)
				end
			end
			return game.rnd:table(candidate)
		end)
	end,
}

return data