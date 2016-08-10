local data = {
	img_name = "gildedgeneral",
	name = "Gilded General",
	faction = "endazu",
	category = "anima",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 1,
	chargeMax = 5,

	hp = 3,

}

data.description = {
	"1/6 charge",
 	"hold/turn +1 charge",
 	"Play an ally, -1 charge:", 
 	"Activate played ally ",
}

data.ability={
	
	onHold = function(card,game)
		game:chargeCard(card)	
	end,

	onTurnStart = function(card,game,from)
		game:chargeCard(card)
	end,

	onCardPlay = function (card,game,target)
		game:activateCard(target)
	end,
}

return data