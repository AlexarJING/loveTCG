local data = {
	img_name = "feast",
	name = "Feast",
	faction = "daramek",
	category = "rituals",
	rare = 3,
	profile = {" Hark, O lost child! Feast with our flock and you shall never feel hunger again. "},
	basePrice = 5,
	back = true,
}

data.description = {
	"Sacrifice weakest ally",
	"Draw 2 allies",
}

data.ability={
	onPlay = function (card,game)
		if game:sacrificeCard("weakest") then
			for i= 1, 2 do
				game:drawCard("my","ally")
			end
		end
	end,
}

return data