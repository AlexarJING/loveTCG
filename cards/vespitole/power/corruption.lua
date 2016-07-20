local data = {
	id = "corruption",
	name = "Corruption",
	faction = "vespitole",
	category = "power",
	rare = 3 ,

	profile = {"A law is only as fair as the men who interpret it. Men with desires, fears, ambitions and secrets. –Sofocatro"},
	basePrice = 13,

	back = true,
}

data.description = {
	"play: draw a card",
	"play: +skull",	
	"each skull +1 gold",
}

data.ability={
	onPlay = function(card,game) 
		game:gain(card,"my","skull") 
		game:drawCard()
		for i= 1, game.my.resource.skull do  
			game:gain(card,"my","gold")
		end
	end,
}

return data