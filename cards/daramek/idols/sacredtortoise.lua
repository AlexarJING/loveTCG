local data = {
	img_name = "sacredtortoise",
	name = "Sacred Tortoise",
	faction = "daramek",
	category = "idols",
	rare = 3 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 4,
	last = true,
	back = true,
}

data.description = {
	"on feed hero magic:", 
	"+1 gold.",
}

data.ability={
	onFeedAlly = function(card,game,who,what)
		if who == game.my.hero.card and what == "magic" then 
			game:gain(card,"my","gold")
		end
	end,
}

return data