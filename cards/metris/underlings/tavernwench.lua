local data = {
	id = "tavernwench",
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
		local weakest
		local weakest_hp = 10
		for i,v in ipairs(self.my.play.cards) do
			if v.hp and not v.cannotScrificed and v.hp<weakest_hp then
				weakest = {v}
				weakest_hp = v.hp
			elseif v.hp and not v.cannotScrificed and v.hp== weakest then
				table.insert(weakest,v)
			end
		end
		if weakest then 
			local target = weakest[love.math.random(#weakest)]
			game:transferCard(target,target.current,game.my.play)
		else 
			game:gain(card,"my","skull")
		end
		
	end,
	

	onDestroyed = function (card,game) if love.math.random()<0.5 then return true end end
}

return data