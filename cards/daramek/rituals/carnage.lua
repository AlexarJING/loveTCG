local data = {
	img_name = "riteofwar",
	name = "Carange",
	faction = "daramek",
	category = "rituals",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 8,
	back = true,
}

data.description = {
	"Sacrfice all allies.",
 	"For each Life Attack "
}

data.ability={
	onPlay = function (card,game)	
		while true do
			local sacrificed = game:sacrificeCard("random")
			if not sacrificed then return end
			for i = 1, sacrificed.hp do
				game:attack(card)
			end
		end

	end,
}

return data