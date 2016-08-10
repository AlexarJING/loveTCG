local data = {
	img_name = "herdingstones",
	name = "Herding Stones",
	faction = "daramek",
	category = "idols",
	rare = 4 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 4,
	last = true,
	back = true,
	charge = 0,
	chargeMax = 4
}

data.description = {
	"on feed hero magic:", 
	"+1 charge.",
	"4 charges:",
	"Gain a random herd "
}

data.ability={
	onFeedAlly = function(card,game,who,what)
		if who == game.my.hero.card and what == "magic" then 
			game:chargeCard(card)
		end
	end,
	
	onFullCharge = function(card,game)
		
		local herds = {"herdofaurochs","herdofboars","herdofgoats","herdofrats"}
		local data = game.cardData.short[table.random(herds)]
		local c = game:makeCard(data)
		game:transferCard(c,game.my.hand)
		card.charge = 0
		card:updateCanvas()
	end
}

return data