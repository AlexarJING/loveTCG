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
		local count =0

		for i,t in ipairs(game.your.play.cards) do
			if t.hp then count=count+1 end
		end
		for i = 1, count+1 do
			game:attack(card)
		end
	end,
}

return data