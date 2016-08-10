local data = {
	img_name = "repopulate",
	name = "repopulate",
	faction = "daramek",
	category = "rituals",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
}

data.description = {
	"Sacrifice weakest ally",
	"Draw 3 allies",
}

data.ability={
	onPlay = function (card,game)
		
		if game:sacrificeCard("weakest") then
			for i= 1, 3 do
				game:drawCard("my","ally")
			end
		end
	
	end,
}

return data