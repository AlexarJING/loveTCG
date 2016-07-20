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
		for i,v in ipairs(game.your.play.cards) do
			if v.hp then game:attack(card) end
		end
	end,
}

return data