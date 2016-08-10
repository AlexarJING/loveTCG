local data = {
	img_name = "odashirsecho",
	name = "Odashir's Echo",
	faction = "endazu",
	category = "incantations",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	chargeInit = 0,
	chargeMax = 3,
	charging = true
}

data.description = {
	"0/3 charge",
 	"On hold: +1 charge",
 	"On play and full charge",
 	"Copy any card",
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
			local copy = game:copyCard(target)
			copy:reset()
			copy.born = game.my
			game:transferCard(copy,copy.current,game.my.hand)
			return true
		end
	end,
}

return data