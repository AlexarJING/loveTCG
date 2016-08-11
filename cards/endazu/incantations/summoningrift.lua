local data = {
	img_name = "summoningrift",
	name = "Summoning Rift",
	faction = "endazu",
	category = "incantations",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 5,
	back = true,
	chargeInit = 0,
	chargeMax = 5,
}

data.description = {
	"0/5 charge",
 	"On hold: +1 charge",
 	"Summon charge count random cards",
 	"Pick one to keep",
}

data.ability={
	onHold = function (card,game)
		game:chargeCard(card)
	end,

	onPlay = function (card,game)
		local candidate = {}
		local lib = game.cardData.index

		for i= 1, card.charge do			
			local target
			repeat
				target = lib[love.math.random(#lib)]
			until not target.isHero and not target.isCoin
			local tCard = game:makeCard(target)
			tCard.born = game.my
			tCard.current = game.my.grave
			table.insert(candidate,tCard)
		end
		game:optionsCards(candidate,game.my.hand)
	end,
}

return data