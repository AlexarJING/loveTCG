local data = {
	img_name = "raktabaan",
	name = "Raktaba'an",
	faction= "endazu",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
	hp = 30
}

data.description = {
	"When you buy a card, 15% chance", 
	"Restock bank from foe's deck",
}

data.ability={

	onCardPlay= function (card,game,target)
		if target.category == "incantations" then
			game:gain(target,"my","magic")
		end
	end
}

return data