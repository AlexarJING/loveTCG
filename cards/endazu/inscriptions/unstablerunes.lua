local data = {
	img_name = "unstablerunes",
	name = "Unstable Runes",
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
}

data.description = {
	"3/20 charge",
 	"Feed magic: -1 charge",
 	"attack x2",
}

data.ability={
	onFeed = function(card,game)
		game:dischargeCard(card)
		game:attack(card)
		game:attack(card)
	end
}

return data