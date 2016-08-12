local data = {
	img_name = "conjuredargoreth", --argorathflower
	name = "Conjured Argoreth",
	faction = "summon",
	rare = 0,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	chargeInit = 1,
	chargeMax = 1,
	last = true,
	hp = 1,
}

data.description = {
	"1/1 charge",
 	"turn: + magic",
 	"discard after use"
}

data.ability={
	onTurnStart = function (card,game)
		for i = 1, card.charge do
			game:gain(card,"my","magic")
		end
	end,
	onHold = function(card,game)
		game:chargeCard(card,true)	
	end
}

return data