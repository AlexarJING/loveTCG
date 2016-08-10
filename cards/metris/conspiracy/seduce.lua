local data = {
	img_name = "seduce",
	name = "Seduce",
	faction = "metris",
	category = "conspiracy",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 4,
}

data.description = {
	"Control a random enemy",
 	"If no enemeies: +2 skull",
 	"Destroy after use ",
}

data.ability={
	onPlay = function(card,game)
		local candidate = game:foe(card,false,true)
		
		if candidate[1] then
			local target = table.random(candidate)
			game:transferCard(target,game.my.play)
		else
			game:gain(card,"my","skull")
			game:gain(card,"my","skull")
		end
	end,
}

return data