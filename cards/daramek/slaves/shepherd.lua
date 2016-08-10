local data = {
	img_name = "shepherd",
	name = "Shepherd",
	faction = "daramek",
	category = "slaves",
	rare = 4 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 9,
	hp = 2,
	cancel = 2,
	last = true,
	back = true,
}

data.description = {
	"Cancel 2 attacks/turn.",
 	"On turn, for each herd:", 
 	"+1 random resource. ",
}

data.ability={
	onTurnStart = function(card,game)
		card.cancel = 2
		for i,v in ipairs(game.my.play.cards) do
			if string.find(v.id,"herdof") then
				game:gain(card,"my","random")
			end
		end
	end
}

return data