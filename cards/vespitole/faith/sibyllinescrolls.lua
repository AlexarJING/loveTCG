local data = {
	id = "sibyllinescrolls",
	name = "Sibylline Scrolls",
	faction = "vespitole",

	category = "faith",
	rare = 3 ,

	profile = {"There are no new ideas. Everything has already been recorded by historians or predicted by sibyls. –Mantessaro Bibliothecarius"},
	basePrice = 6,

	block = false,

	back = true,
}

data.description = {
	"turn: each gold + gold",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard() 
		local candidate = {}
		local cards = {unpack(game.my.deck.cards)}
		for i = 1,3 do
			if #cards==0 then break end
			local index = love.math.random(#cards)
			table.insert(candidate, cards[index])
			table.remove(cards, index)
		end
		if #candidate == 0 then return end
		game.show:addOptions(candidate,game.my.deck)
	end,
}

return data