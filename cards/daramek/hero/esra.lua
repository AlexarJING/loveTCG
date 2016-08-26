local data = {
	img_name = "ezra",
	name = "Esra",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 3,
	hp = 30
}

data.description = {
	"When drawing your hand:",
	" One drawn card is an ally ",
}

data.ability={
	onDrawHand = function (card,game)
		
		if #game.my.hand.cards>= game.my.handsize then game:refillCard();return end
		

		local drawCount = game.my.turnDrawCount

		if drawCount >0 and game:drawCard("my","ally") then
			drawCount = drawCount -1
		end

		for i = 1, drawCount do
			if #game.my.hand.cards>= game.my.handsize then break end
			game:drawCard()
		end
		game:refillCard()
		return true
	end,
}

return data