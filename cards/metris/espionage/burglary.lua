local data = {
	img_name = "burglary",
	name = "Burglary",
	faction = "metris",
	category = "espionage",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 7,
}

data.description = {
	"Steal the cheapest card",
	"from your foe's bank",
 	"Destroy after use",
}

data.ability={
	onPlay = function(card,game)
		local cheapest
		local price = 100
		for i,v in ipairs(game.your.bank.cards) do
			if v.price<price then
				cheapest = v
				price = v.price
			end
		end
		if not cheapest then return end
		game:transferCard(cheapest,game.my.hand)
	end,
}

return data