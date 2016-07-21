local data = {
	id = "madamaline",
	name = "madam aline",
	faction= "vespitole",

	profile = {"Torturers, soldiers, spies, and kings all spill fields of blood to wrench whispered half truths from their victims. Ours lay bare their every secret without a drop spilt. –Madam Aline"},

	isHero = true,
	rare = 4,
}

data.description = {
	"start with",
	"2 courtsan",
}

data.ability={
	
	onTurnStart = function(card,game) 
		if game.turnCount == 1 then
			game:transferCard(game.my.hand.cards[1],game.my.hand,game.my.deck)
			game:transferCard(game.my.hand.cards[1],game.my.hand,game.my.deck)
			local data = table.copy(game.cardData.vespitrole.courtsan,{},true)
			data.level = 3
			game:transferCard(game.my.library:makeCard(data),game.my.library,game.my.hand)
			game:transferCard(game.my.library:makeCard(data),game.my.library,game.my.hand)
		end
	end,
}

return data