local data = {
	img_name = "valdorian",
	name = "Valdorian",
	faction= "metris",

	profile = {"no money, you can do nothing!"},

	isHero = true,
	rare = 2,
	hp = 30
}

data.description = {
	"turn: 35% chance:", 
	"Draw from foe's deck",
	"Play foe's coin, 35%: +1 gold"
}

data.ability={
	onTurnStart = function(card,game) 
		if  game.rnd:random()<0.35 then
			game:drawCard("your")
		end
	end,
	onCardPlay = function (card,game,target)
		if target.isCoin and target.born~=game.my then
			if  game.rnd:random()<0.35 then
				game:gain(target,"my","gold")
			end
		end
	end
}

return data