local data = {
	id = "misinformation",
	name = "Misinformation",
	faction = "metris",
	category = "espionage",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 5,
}

data.description = {
	"Steal the cheapest card",
	"from your foe's bank",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		local candidate = {}
		local cards = {unpack(game.your.bank.cards)}
		if #cards == 0 then return end
		game:optionsCards(candidate)
		game.show.onChoose = function(card,game,target)
			local cards = game.my.library.cards

			for i = #cards , 1, -1 do
				if cards[i].id == target.id then
					table.remove(cards,i)
				end
			end
			
			local cards = game.my.bank.cards

			for i = #cards , 1, -1 do
				if cards[i].id == target.id then
					game:killCard(cards[i])
				end
			end

			for i,v in ipairs(game.show.cards) do
				game:transferCard(v,v.current,v.born.grave)
			end
		end
	end,
	onKilled = function (card,game)
		local cards = game.my.library.cards

		for i = #cards , 1, -1 do
			if cards[i].id == card.id then
				table.remove(cards,i)
			end
		end
		
		local cards = game.my.bank.cards

		for i = #cards , 1, -1 do
			if cards[i].id == card.id then
				game:killCard(cards[i])
			end
		end
	end
}

return data