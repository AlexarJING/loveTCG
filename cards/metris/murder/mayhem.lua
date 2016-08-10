local data = {
	img_name = "mayhem",
	name = "Mayhem",
	faction = "metris",
	category = "murder",
	rare = "H" ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 5,
}

data.description = {
	"Discard everyone's allies",
 	"Or if no enemies: 4x attack",
 	"Destroy after use"
}

data.ability={
	onPlay = function(card,game)		
		local discard = false

		for i,v in ipairs(game:foe(card,true,true)) do	
			game:transferCard(v,v.born.deck)
			discard = true	
		end
		
		for i,v in ipairs(game:ally(card,true,true)) do
			game:transferCard(v,v.born.deck)
		end

		if not discard then 
			for i=1,4 do
				game:attack(card)
			end
		end
	end,
}

return data