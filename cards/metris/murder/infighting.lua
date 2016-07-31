local data = {
	id = "infighting",
	name = "Infighting",
	faction = "metris",
	category = "murder",
	rare = 1 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,	
}

data.description = {
	"Enemies attack each other",
 	"No enemies: Restock bank",
	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		local candidate = {}
		for i,v in ipairs(game.your.play.cards) do
			if v.hp then table.insert(candidate,v) end
		end
		if #candidate == 0 then
			game:refill()
		else
			for i= 1, #candidate do
				game:attack(card)
			end
		end
	end,
}

return data