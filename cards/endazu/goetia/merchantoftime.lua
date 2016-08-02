local data = {
	id = "merchantoftime",
	name = "Merchant of Time",
	faction = "endazu",
	category = "goetia",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 8,
	back = true,
	last =true,
	combo = true
}

data.description = {
	"Hero loses half their Life",
 	"Take another turn",
 	"Max consecutive 2 turns ",
}

data.ability={

	onPlay = function(card,game)
		game.my.resource.hp = math.ceil(game.my.resource.hp/2)

	end,

}

return data