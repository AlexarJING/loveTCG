local data = {
	img_name = "empoweringseal",
	name = "Empowering Seal",
	faction = "endazu",
	category = "inscriptions",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 3,
	chargeMax = 20,
	last = true,
	foodType = "magic",
}

data.description = {
	"3/20 charge",
 	"Feed magic: -1 charge ",
 	"2 anima +1 permanent magic"
}

data.ability={
	
	onFeed = function(card,game)
		game:dischargeCard(card)
		game:chargeCard("random",true,"anima")
		game:chargeCard("random",true,"anima")
	end
}

return data