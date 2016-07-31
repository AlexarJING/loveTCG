local data = {
	id = "mayhem",
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
	onTurnStart = function(card,game)		
		local discard = false

		for i,v in ipairs(game.your.play.cards) do
			if v.hp then 
				game:killCard(v) 
				discard = true
			end
		end
		
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then 
				game:killCard(v) 
			end
		end

		if not discard then 
			for i=1,4 do
				game:attack(card)
			end
		end
	end,
}

return data