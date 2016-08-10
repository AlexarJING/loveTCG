local data = {
	img_name = "regentmarsh",
	name = "Regent Marsh",
	faction= "vespitole",

	profile = {"To master a trade one must do more than study. Stonemasons must work the rock. Farriers must work the forge. So it is also with war. Let us go and hone our craft. –Regent Marsh"},

	isHero = true,
	rare = "E",
	hp = 30
}

data.description = {
	"feed ally: ",
	"50% attack",
}

data.ability={
	onFeedAlly = function(card,game) 
		if love.math.random()<0.5 then  game:attack(card) end
	end,
}

return data