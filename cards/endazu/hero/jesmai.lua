local data = {
	id = "jesmai",
	name = "Jesmai",
	faction= "endazu",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 4,
	hp = 30
}

data.description = {
	"Feed any Anima:",
	"It gains +1 permanent ", 
}

data.ability={

	onFeedAlly = function(card,game,target)
		if target.category == "anima" then
			game:chargeCard(target)
		end
	end --(self.my.hero.card,self,card) 
}

return data