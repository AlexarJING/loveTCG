local data = {
	img_name = "wardingcircle",
	name = "Warding Circle",
	faction = "endazu",
	category = "inscriptions",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 3,
	chargeMax = 20,
	last = true,
	canFeedMagic = true,
	intercept = true
}

data.description = {
	"3/20 charge",
 	"Feed magic: +1 charge",
 	"For each charge: Intercept",
}

data.ability={
	onFeed = function(card,game)
		game:chargeCard(card)
	end
}

return data