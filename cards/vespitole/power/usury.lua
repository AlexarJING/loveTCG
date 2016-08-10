local data = {
	img_name = "usury",
	name = "Usury",
	faction = "vespitole",
	category = "power",
	rare = 3 ,

	profile = {"Gold is power. Anyone who disagrees possesses neither.	-Captain Listrata"},

	basePrice = 5,


	last = 4,

	back = true,
}

data.description = {
	"play: draw a card",
	"foe gains 6 gold",
	"turn: foe pays 2 gold",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i = 1,8 do
			game:gain(card,"your","gold")
		end
	end,
	onTurnStart = function(card,game)
		for i = 1, 2 do
			if game:lose(card,"your","gold") then
				game:gain(card,"my","gold")
			end
		end
	end
}

return data