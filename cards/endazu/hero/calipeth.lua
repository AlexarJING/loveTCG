local data = {
	img_name = "calipeth",
	name = "Calipeth",
	faction= "endazu",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 3,
	hp = 30
}

data.description = {
	"+1 charge to Inscriptions ", 
}

data.ability={

	onCardPlay= function (card,game,target)
		if target.category == "inscriptions" then
			game:chargeCard(target)
			card:standout()
		end
	end
}

return data