local data = {
	img_name = "mogesh",
	name = "Mogesh",
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
	onGain = function(card,game,who,what) --self.my.hero.card,self,who,what
		if who ~= "my" then return end
		if (what == "skull" or what == "food")
			and love.math.random()<0.5 then
			return "magic"
		end 
	end
}

return data