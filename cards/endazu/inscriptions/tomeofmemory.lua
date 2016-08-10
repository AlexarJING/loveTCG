local data = {
	img_name = "tomeofmemory",
	name = "Tome of Memory",
	faction = "endazu",
	category = "inscriptions",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 3,
	back = true,
	chargeInit = 3,
	chargeMax = 6,
	last = true,
	awaken = true,
	canFeedMagic = true,
}

data.description = {
	"3/6 charge",
 	"turn: -1 charge",
 	"feed magic: +3 charge",
 	"charged: +1 hand size"
}

data.ability={
	onPlay = function (card,game)
		game.my.handsize = game.my.handsize+1
	end,
	onTurnStart = function (card,game)
		game:dischargeCard(card) 
	end,
	onFeed = function(card,game)
		for i = 1, 3 do
			game:chargeCard(card)
		end	
	end,
	onSleep = function (card,game)
		game.my.handsize = game.my.handsize-1
	end, 
	onAwake = function (card,game)
		game.my.handsize = game.my.handsize+1
	end
}

return data