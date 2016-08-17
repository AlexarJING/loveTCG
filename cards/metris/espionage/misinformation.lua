local data = {
	img_name = "misinformation",
	name = "Misinformation",
	faction = "metris",
	category = "espionage",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 5,
}

data.description = {
	"Pick a card from Foe's Bank",
	"remove it and self",
}

data.ability={
	onPlay = function(card,game)
		
		local cards = {unpack(game.your.bank.cards)}
		if #cards == 0 then return end

		game:optionsCards(card,cards)
		game.show.onChoose = function(target,game)
	
			for i,v in ipairs(game.your.library.cards) do
				if v.id == target.id and v.level == target.level then
					table.remove(game.your.library.cards, i)
				end
			end

		
			for i,v in ipairs(game.show.cards) do
				game:transferCard(v,v.born.grave)
			end
		

		end
	end,
	onKilled = function (card,game)
		for i,v in ipairs(game.my.library.cards) do
			if v.id == card.id and v.level == card.level then
				table.remove(game.my.library.cards, i)
			end
		end
		
		for i,v in ipairs(game.my.bank.cards) do
			if v.id == card.id and v.level == card.level then
				game:transferCard(v,v.current,v.born.grave)
			end	
		end

		for i,v in ipairs(game.my.hand.cards) do
			if v.id == card.id and v.level == card.level then
				game:transferCard(v,v.current,v.born.grave)
			end	
		end
	end
}

return data