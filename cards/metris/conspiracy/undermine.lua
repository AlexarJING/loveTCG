local data = {
	img_name = "undermine",
	name = "Undermine",
	faction = "metris",
	category = "conspiracy",
	rare = 2 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 2,
	last = 2
}

data.description = {
	"For 2 turns",
	"Foe draws 1 fewer cards",
 	"Destroy after use ",
}

data.ability={
	onPlay = function(card,game)
		game.your.turnDrawCount = game.your.turnDrawCount -1
	end,
	onKilled = function(card,game)
		game.your.turnDrawCount = game.your.turnDrawCount +1
	end
}

return data