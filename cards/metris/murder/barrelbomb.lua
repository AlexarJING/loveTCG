local data = {
	id = "barrelbomb",
	name = "Barrel Bomb",
	faction = "metris",
	category = "murder",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 10,
	last = 4
}

data.description = {
	"In 3 turns: attack x11",
 	"Destroy after use",
}

data.ability={
	onTurnStart = function(card,game)		
		if card.last == 1 then
			for i = 1, 11 do
				game:attack(card)
			end
		end
		game:killCard(card)	
	end,
}

return data