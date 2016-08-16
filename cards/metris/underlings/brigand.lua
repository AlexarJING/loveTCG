local data = {
	img_name = "brigand",
	name = "Brigand",
	faction = "metris",
	category = "underlings",
	rare = 3,
	profile = {"You have us until harvest, and not a day after. –Johannas Freeman"},
	basePrice = 5,
	hp = 2,
	last = true,
}

data.description = {
	"On turn: steal random.",
	"if failed: attack",
	"50%: destroy when killed ",
}

data.ability={
	onTurnStart = function (card,game) 
		if not game:steal(card,"random") then
			game:attack(card)
		end
	end,
	

	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data