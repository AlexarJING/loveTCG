local data = {
	id = "leadthecharge",
	name = "Lead the Charge",
	faction = "vespitole",
	category = "war",
	rare = "H" ,
	profile = {"Men will always fight harder for a lord with battle scars.–Sister Ysadora"},
	basePrice = 8,
	back = true,
}

data.description = {
	"play: draw a card",
	"attack x2",
	"ignores intercept"

}

data.ability={
	onPlay = function (card,game) game:drawCard() end,
	onTurnStart = function (card,game) 
		game:attack(card,nil,true) 
		game:attack(card,nil,true) 
	end,
}

return data