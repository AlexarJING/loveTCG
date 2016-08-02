local data = {
	id = "banishinggust",
	name = "Banishing Gust",
	faction = "endazu",
	category = "incantations",
	rare = "H",
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 0,
	chargeMax = 2,
	charging = true
}

data.description = {
	"0/2 charge",
 	"On hold: +1 charge",
 	"On play and full charge",
 	"discard any card",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onFullCharge = function(card,game)
		card.charging = false
	end,
	onPlay = function (card,game)
		game.my.needTarget = true
		game.my.selectTarget = function(game,target)
			if target.current == game.my.deck or target.current == game.your.deck then return end
			if target == card then return end
			game:destroyCard(target)
			game:killCard(card)
			return true
		end
	end,
}

return data