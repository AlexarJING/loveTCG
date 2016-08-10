local data = {
	img_name = "arsenic",
	name = "Arsenic",
	faction = "metris",
	category = "murder",
	rare = 4 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 12,
	last = true,
	poison = true
}

data.description = {
	"On turn, for each poison:",
	"Attack hero",
 	"Ignores intercept ",
}



data.ability={
	onTurnStart = function(card,game)
		
		for i,v in ipairs(game.my.play.cards) do
			if v.poison then game:attack(card,"hero",true) end
		end

	end,
}

return data