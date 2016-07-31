local data = {
	id = "herdingstones",
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
	onFeedMagic = function(card,game)
		game:chargeCard(card)
	end,
	onFullCharge = function(card,game)
		game:drawCard("my",function(cards)
			for i,v in ipairs(cards) do
				if string.find(v.id,"herdof") then
					return v
				end
			end
		end)
		card.charge=0
	end
}

return data