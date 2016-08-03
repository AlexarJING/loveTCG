local data = {
	id = "oxelixir",
	name = "Aurochs Elixir",
	faction = "daramek",
	category = "herd",
	rare = 4 ,
	profile = {"Gather the coarse, waxy hairs from adult males. The more the better. Soak them in an open basket with water and finch weed. They will swell and yellow until a jelly forms that must be collected with the shell of a hess beetle.–Esra"},
	basePrice = 4,
	--hp = 2,
	--last = true,
	back = true,
}

data.description = {
	"Restock Herd of Aurochs",
	"Fully heal all allies.",
	"Activate all aurochs."
}

data.ability={
	onPlay = function (card,game) 
		game:refill("my","herdofaurochs",card)
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then
				v.hp = v.hp_max
			end
		end
		for i,v in ipairs(game.my.play.cards) do
			if v.id == "herdofaurochs" or v.id == "colossalaurochs" then
				v.ability.onTurnStart(game,v)
			end
		end
	end,
}

return data