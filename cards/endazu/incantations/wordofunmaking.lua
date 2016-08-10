local data = {
	img_name = "wordofunmaking",
	name = "Word of Unmaking",
	faction = "endazu",
	category = "incantations",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	chargeInit = 0,
	chargeMax = 3,
	charging = true,
	last =true
}

data.description = {
	"0/3 charge",
 	"On hold: +1 charge",
 	"On play and full charge",
 	"Destroy any card ",
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
			game:killCard(target)
			game:killCard(card)
			return true
		end
	end,
}

return data