local data = {
	img_name = "sandstorm",
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
		game.my.targetSelected = function(game,target)
			if target.current == game.my.deck or target.current == game.your.deck then return end
			if target.current == game.my.hero or target.current == game.your.hero then return end
			if target == card then return end
			game:killCard(target)
			game:killCard(card)
			return true
		end
	end,
}

return data