local data = {
	id = "wagonbomb",
	name = "Wagon Bomb",
	faction = "metris",
	category = "murder",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 14,
	last = 4
}

data.description = {
	"In 3 turns: attack x16",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)		
		if card.last == 1 then
			for i = 1, 16 do
				game:attack(card)
			end
		end
		game:killCard(card)	
	end,
}

return data