local data = {
	id = "birondelle",
	name = "Birondelle",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 4,
}

data.description = {
	"When you buy a card, 15% chance", 
	"Restock bank from foe's deck",
}

data.ability={
	--onCardBuy(hero,game,card)

	onCardBuy= function (card,game,target)
		if love.math.random()<0.15 then
			game:refill("your")
		end
	end
}

return data