local data = {
	img_name = "fireship", 
	name = "Fire Ship",
	faction = "summon",
	rare = 0,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	last = true,
	hp = 3,
	timer = 4,
	basePrice = 4,
	back = true
}

data.description = {
 	"on time up:",
 	"attack x6",
}

data.ability={
	onTimeUp = function(card,game) 
		for i = 1,6 do
			game:attack(card) 
		end
	end,
}

return data