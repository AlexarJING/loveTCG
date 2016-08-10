local data = {
	img_name = "wordofblight",
	name = "Poem of Blight",
	faction = "endazu",
	category = "incantations",
	rare = 2,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
	chargeInit = 1,
	chargeMax = 20,
}

data.description = {
	"1/20 charge",
 	"On hold: +2 charge",
 	"On play: for each charge",
 	" Foe loses 1 resource  ",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
		game:chargeCard(card)
	end,
	onPlay = function (card,game)
		for i = 1,card.charge do 
			game:lose(card,"your","random")
		end
	end,
}

return data