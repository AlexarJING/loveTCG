local data = {
	id = "scrivener",
	name = "Scrivener",
	faction = "daramek",
	category = "slaves",
	rare = 2 ,
	profile = {"Seek the altar deep within the earth's wet maw and transcribe each symbol exactly. " },
	basePrice = 6,
	hp = 1,
	last = true,
	back = true,
	cannotScrifice = true,
}

data.description = {
	"On turn/play: Draw a rite",
	"Play ritual: +1 resource",
 	"Can't be sacrificed",
}

data.ability={
	onTurnStart = function (card,game) 
		game:drawCard("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.category=="rituals" then
					table.insert(candidate,v)
				end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
		card.currentCardPlayed = game.cardPlayCount
	end,
	onPlay = function (card,game)
		game:drawCard("my",function(cards)
			local candidate = {}
			for i,v in ipairs(cards) do
				if v.category=="rituals" then
					table.insert(candidate,v)
				end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
		card.currentCardPlayed = game.cardPlayCount
	end,
	always = function (card,game)
		if card.current.root ~= game.turn then return end
		if game.cardPlayCount> card.currentCardPlayed then
			for i = 1, game.cardPlayCount-card.currentCardPlayed do
				if game.lastPlayed.category == "rituals" then
					game:gain(card,"my","random")
				end
			end
			card.currentCardPlayed = game.cardPlayCount
		end
	end,
}

return data