local data = {
	id = "malediction",
	name = "Malediction",
	faction = "vespitole",

	category = "faith",
	
	rare = 3 ,

	profile = {" It's not witchcraft when God does it. –Cardinal Pocchi"},

	basePrice = 11,

	back = true,
}

data.description = {
	"for each enemy attack",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		
		for i,v in ipairs(game:foe()) do
			game:attack(card)
		end
	end,
}

return data