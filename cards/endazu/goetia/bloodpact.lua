local data = {
	img_name = "bloodpact",
	name = "Blood Pact",
	faction = "endazu",
	category = "goetia",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 3,
	chargeMax = 3,
	foodType = "hp",
	feedAmount = 2,
	last =true
}

data.description = {
	"3/3 charge",
 	"Feed 2 Life: -1 charge",
 	"+1 charge to random"
}

data.ability={

	onFeed = function(card,game)

		game:dischargeCard(card)
		game:chargeCard("random")
		
	end,

}

return data