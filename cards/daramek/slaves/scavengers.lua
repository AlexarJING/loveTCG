local data = {
	id = "scavengers",
	name = "Scavengers",
	faction = "daramek",
	category = "slaves",
	rare = 1 ,
	profile = {"With silent devotion, they caress the Earth with tiny fingers under the night sky. Blessed is their fur, their dung and their blood.  –Litany of the Shepherd" },
	basePrice = 5,
	hp = 1,
	last = true,
	back = true,
}

data.description = {
	"On turn/play",
	"+1 resource",
	"On Dying, 50% return",
}

data.ability={
	onTurnStart = function (card,game) 
		game:gain(card,"my","random")		--card,who,what
	end,
	onPlay = function (card,game)
		game:gain(card,"my","random")
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