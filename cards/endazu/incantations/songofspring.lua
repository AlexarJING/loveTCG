local data = {
	img_name = "songofspring",
	name = "Song of Spring",
	faction = "endazu",
	category = "incantations",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 20,
}

data.description = {
	"1/20 charge",
 	"On hold: +1 charge",
 	"On play: for each charge",
 	"Summon flower ",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		for i= 1, card.charge do
			game:summon(card,"conjuredargoreth")
		end
	end,
}

return data