local data = {
	id = "riteofbattle",
	name = "Bloodlust",
	faction = "daramek",
	category = "rituals",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	last = true
}

data.description = {
	"Pick an enemy:",
	" Attack it until dead",
}

data.ability={
	onPlay = function (card,game)
		local options = {}
		for i,v in ipairs(game.your.play.cards) do
			if v.hp then table.insert(options,v.hp) end
		end
		if not options[1] then return end

		game:optionsCards(options)
		
		game.show.onChoose = function(target,game)
			repeat
				game:attack(card,target)
			until target.hp<1
			game:killCard(card)
		end		
	end,
}

return data