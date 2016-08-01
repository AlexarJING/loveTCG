local data = {
	id = "seduce",
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
		local candidate = {}
		for i,v in ipairs(game.your.play.cards) do
			if v.hp then table.insert(candidate, v) end
		end		
		if candidate[1] then
			local target = table.random(candidate)
			game:transferCard(target,target.current,game.my.play)
		else
			game:gain(card,"my","skull")
			game:gain(card,"my","skull")
		end
	end,
}

return data