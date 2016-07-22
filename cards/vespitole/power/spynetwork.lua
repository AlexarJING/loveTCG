local data = {
	id = "spynetwork",
	name = "Spy Network",
	faction = "vespitole",
	category = "power",
	rare = "H" ,

	profile = {"A commoner will confess any secret for the mere thrill of participating in something bigger than their tiny little lives. –Sofocatro"},

	basePrice = 10,


	last = false,

	back = true,
}

data.description = {
	"play: draw a card",
	"each ally +1 skull",
}

data.ability={
	onPlay = function(card,game) 
		game:drawCard()
		local count =0

		for i,t in ipairs(game.your.play.cards) do
			if t.hp then count=count+1 end
		end
		for i = 1, count+1 do
			game:gain(v,"my","skull")
		end
	end,
}

return data