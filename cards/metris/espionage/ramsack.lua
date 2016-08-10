local data = {
	img_name = "ransack",
	name = "Ransack",
	faction = "metris",
	category = "espionage",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 6,
}

data.description = {
	"Draw 3 cards from foe ",
	"Steal one, if coin +6 gold",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game) 
		local candidate = {}
		local cards = {unpack(game.your.deck.cards)}
		for i = 1,3 do
			if #cards==0 then break end
			local index = love.math.random(#cards)
			table.insert(candidate, cards[index])
			table.remove(cards, index)
		end
		if #candidate == 0 then return end
		game:optionsCards(candidate)
		game.show.onChoose = function(card,game)
			game:transferCard(card,game.my.hand)
			if card.isCoin then
				for i = 1,6 do
					game:gain(card,"my","gold")
				end
			end
		end
	end,
}

return data