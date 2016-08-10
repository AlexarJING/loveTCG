local data = {
	img_name = "stampede",
	name = "Stampede",
	faction = "daramek",
	category = "slaves",
	rare = "H" ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 3,
	back = true,
}

data.description = {
	"All allies attack",
}

data.ability={
	onPlay = function(card,game)
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then
				game:attack(card)
			end
		end
	end
}

return data