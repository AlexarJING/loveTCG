local data = {
	id = "banker",
	name = "banker",
	faction = "vespitole",

	category = "prosperity",
	rare = 4 ,

	profile = {"The wealthy wise duchess always knew: loose in the fingers, the coins fall through. In the bed of straw thieving rats will chew. In the bank of stone, one ducat becomes two. –The Miser and the Duchess"},

	basePrice = 8,
	hp = 1,

	block = false,

	last = true,

	back = true,
}

data.description = {
	"turn: each gold + gold",
	"play: draw a card",
}

data.ability={
	onPlay = function(card,game) game:drawCard() end,
	onTurnStart = function(card,game) 
		for i = 1, game.my.resource.gold do
			game:gain(card,"my","gold")
		end
	end,
}

return data