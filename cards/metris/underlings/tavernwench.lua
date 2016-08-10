local data = {
	img_name = "tavernwench",
	name = "Tarvern Wench",
	faction = "metris",
	category = "underlings",
	rare = "H",
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 6,
	hp = 1,
	last = true,
}

data.description = {
	"On turn: control weakest.",
	"No enemies: +1 skull",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) 
		local weakest = game:weakestAlly(game.your)
		if weakest then 
			game:transferCard(weakest,game.my.play)
		else 
			game:gain(card,"my","skull")
		end
		
	end,
	

	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data