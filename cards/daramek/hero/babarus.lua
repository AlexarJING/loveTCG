local data = {
	img_name = "babarus",
	name = "Babarus",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 4,
	hp =30
}

data.description = {
	"When you gain a food or skull",
	"50% chance it becomes magic ",
}

data.ability={
	onGain = function(card,game,what) --self.my.hero.card,self,who,what
		if (what == "skull" or what == "food")
			and game.rnd:random()<0.5 then
			game:lose(card,"my",what)
			game:gain(card,"my","magic")
		end 
	end
}

return data