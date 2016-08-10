local data = {
	img_name = "waroxen",
	name = "Colosal Aurochs",
	faction = "daramek",
	category = "herd",
	rare = 3 ,
	profile = {"Graze not on grass this day, for your horns will rake the sky, and your rumen will boil with blood! –Mogesh" },
	basePrice = 13,
	hp = 5,
	last = true,
	back = true,
}

data.description = {
	"On turn: attack x5",
	"When life reduced to 0",
	"50%: return to hand"
}

data.ability={
	onTurnStart = function (card,game)
		for i= 1, 5 do
			game:attack(card)
		end
	end,
	onDying = function(card,game)
		if love.math.random()<0.5 then
			return "toHand"
		else
			return "death"
		end
	end
}

return data