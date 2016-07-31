local data = {
	id = "coupdegrace",
	name = "Coup de Grace",
	faction = "metris",
	category = "murder",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 8,
}

data.description = {
	"For each card control:",
	"Attack foe's hero x2",
 	"Destroy after use ",
}

data.ability={
	onPlay = function(card,game)
		local count = #game.my.play.cards
		for i  = 1, count*2 do		
			game:attack(card,"hero")
		end
	end,
}

return data