local data = {
	id = "warship",
	name = "Warship",
	faction = "vespitole",
	category = "war",
	rare = 4 ,
	profile = {" have spent more time in armor than most have spent awake. My skin is metal, my legs: a horse, and my arm a vengeful sword, honed on bones of weaker men. –Sir Mathias"},
	basePrice = 14,
	hp = 5,
	last = true,
	back = true,
}

data.description = {
	"play: draw a card",
	"turn: attack x5",

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) 
		for i= 1, 5 do
			game:attack(card)
		end
	end,
}

return data