local data = {
	img_name = "fertilityoffering",
	name = "Fertility Offering",
	faction = "daramek",
	category = "rituals",
	rare = 3,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 4,
	back = true,
}

data.description = {
	"Sacrifice random ally",
	"copy that ally",
}

data.ability={
	onPlay = function (card,game)
		local sacrificed = game:sacrificeCard("random")
		if not sacrificed then return end
		local copy = game:copyCard(sacrificed)
		--game:transferCard(card ,from,to ,pos,passResort)
		game:transferCard(copy,copy.current,game.my.play)
	
	end,
}

return data