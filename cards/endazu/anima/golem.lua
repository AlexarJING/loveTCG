local data = {
	id = "golem",
	name = "Golem",
	faction = "endazu",
	category = "anima",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
	chargeInit = 1,
	chargeMax = 3,
	last = true,
	hp = 5,
	intercept= true,
	undead = true
}

data.description = {
	"1/3 charge",
 	"On turn, for each charge: heal",
	"Intercepts",

}

data.ability={
	onTurnStart = function (card,game)
		for i = 1, card.charge do
			game:healCard(card)
		end
	end,
}

return data