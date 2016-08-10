local data = {
	img_name = "gravecontract",
	name = "Grave Contract",
	faction = "endazu",
	category = "inscriptions",
	rare = 2,
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
 	"feed magic: -1 charge",
 	"Summon Gilded Warrior"
}

data.ability={
	onFeed = function(card,game)
		game:dischargeCard(card)
		game:summon("gildedwarriors")
	
	end
}

return data