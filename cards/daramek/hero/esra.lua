local data = {
	id = "esra",
	name = "Esra",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 3,
}

data.description = {
	"When drawing your hand:",
	" One drawn card is an ally ",
}

data.ability={
	onDrawHand = function (game)
		game:drawCard("my",function()
			local candidate = {}
			for i,v in ipairs(game.my.deck.cards) do
				if v.hp then table.insert(candidate,v) end
			end
			if not candidate[1] then return end
			return candidate[love.math.random(#candidate)]
		end)
		for i = 1, 2 do
			if #game.my.hand.cards>3 then break end
			game:drawCard()
		end
		game:refillCard()
	end,
}

return data