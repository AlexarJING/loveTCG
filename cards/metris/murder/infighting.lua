local data = {
	img_name = "infighting",
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
		local candidate = game:foe(card,false,true)
		if #candidate == 0 then
			game:refill()
		else
			for i,v in ipairs(candidate) do
				game:attack(v,"infighting")
			end
		end
	end,
}

return data