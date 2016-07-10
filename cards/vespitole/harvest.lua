local data = {
	id = "harvest",
	name = "harvest",
	faction = "vespitole",
	category = "prosperity",
	rare = 3 ,

	profile = {"A commoner will confess any secret for the mere thrill of participating in something bigger than their tiny little lives. –Sofocatro"},

	basePrice = 10,


	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"each ally +1 food",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then
				game:gain(v,"my","food")
			end
		end
	end,
}

return data