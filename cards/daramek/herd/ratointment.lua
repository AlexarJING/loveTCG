local data = {
	img_name = "ratointment",
	name = "Rat Ointment",
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
	"play: Restock Herd of Rats",
	"Sacrifice a Herd of Rats:",
	"Gain a War Rat"
}

data.ability={
	onPlay = function (card,game) 
		game:refillCard("my","herdofrats",card.level)

		if game:sacrificeCard("herdofrats") then
			local d = game.cardData.short.warrats
			d.level = card.level
			local copy = game:makeCard(d)
			game:drawCard("my",copy)
		end
	end,
}

return data