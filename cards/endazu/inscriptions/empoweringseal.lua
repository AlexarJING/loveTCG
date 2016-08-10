local data = {
	img_name = "empoweringseal",
	name = "Empowering Seal",
	faction = "endazu",
	category = "inscriptions",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 3,
	chargeMax = 20,
	last = true,
	canFeedMagic = true,
}

data.description = {
	"3/20 charge",
 	"Feed magic: -1 charge ",
 	"2 anima +1 permanent magic"
}

data.ability={
	
	onFeed = function(card,game)
		
		game:dischargeCard(card)
		local canditate ={}
		for i,v in ipairs(game.my.play.cards) do
			if v.category == "anima" then
				table.insert(canditate,v)
			end
		end

		for i,v in ipairs(game.my.hand.cards) do
			if v.category == "anima" then
				table.insert(canditate,v)
			end
		end

		game:chargeCard(table.random(canditate))
		game:chargeCard(table.random(canditate))
	end
}

return data