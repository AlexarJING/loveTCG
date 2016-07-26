local data = {
	id = "marshall",
	name = "Marshall",
	faction = "vespitole",
	category = "war",
	rare = 2 ,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 8,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"play: draw a card",
	"turn: activate all allies",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) 
		if game.my.hero.card.ability.onTurnStart then
			game.my.hero.card.ability.onTurnStart(game.my.hero.card,game)
		end
		for i,v in ipairs(game.my.play.cards) do
			if v.ability.onTurnStart and v.id~="marshall" then
				v.ability.onTurnStart(v,game)
			end
		end
	end,
}

return data