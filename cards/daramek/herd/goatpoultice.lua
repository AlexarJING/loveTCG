local data = {
	id = "goatpoultice",
	name = "Goat Poultice",
	faction = "daramek",
	category = "herd",
	rare = 3 ,
	profile = {"Gather the coarse, waxy hairs from adult males. The more the better. Soak them in an open basket with water and finch weed. They will swell and yellow until a jelly forms that must be collected with the shell of a hess beetle.–Esra"},
	basePrice = 4,
	--hp = 2,
	--last = true,
	back = true,
}

data.description = {
	"Restock Herd of Goats.",
 	"Draw Herd of Goats",
 	"Activate all goats", 
}

data.ability={
	onPlay = function (card,game) 
		game:refill("my","herdofgoats",card)
		game:drawCard("my","herdofgoats",card)
		for i,v in ipairs(game.my.play.cards) do
			if v.id == "herdofgoats" then
				v.ability.onTurnStart(game,v)
			end
		end
	end,
}

return data