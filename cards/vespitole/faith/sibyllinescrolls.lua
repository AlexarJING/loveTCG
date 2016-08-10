local data = {
	img_name = "sibyllinescrolls",
	name = "Sibylline Scrolls",
	faction = "vespitole",

	category = "faith",
	rare = 3 ,

	profile = {"There are no new ideas. Everything has already been recorded by historians or predicted by sibyls. –Mantessaro Bibliothecarius"},
	basePrice = 6,

	intercept = false,

	back = true,
}

data.description = {

	"play: draw 3 card",
	"play one of them"
}

data.ability={
	onPlay = function(card,game) 
		local candidate = {}
		local cards = {unpack(game.my.deck.cards)}
		for i = 1,3 do
			if #cards==0 then break end
			local c = table.pickRandom(cards)
			table.insert(candidate, c)
		end
		if #candidate == 0 then return end
		game:optionsCards(candidate)
	end,
}

return data