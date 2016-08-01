local data = {
	id = "forgery",
	name = "Forgery",
	faction = "metris",
	category = "espionage",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
	last = true
}

data.description = {
	"Next card foe buys",
	"Gains a copy",
 	"Destroy after use",
}

data.ability={
	onFoeBuy = function(card,game,target)
		local copy = game:copyCard(target)
		copy.born = card.born
		game:transferCard(copy,copy.current,card.born.hand)
	end,
}

return data