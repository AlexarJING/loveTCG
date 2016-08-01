local data = {
	id = "impersonate",
	name = "Impersonate",
	faction = "metris",
	category = "espionage",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 2,
}

data.description = {
	"Draw a random card",
	"from foe's hand",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		local target = table.random(game.your.hand.cards)
		if not target then return end
		game:transferCard(target,target.current,game.my.hand)
	end,
}

return data