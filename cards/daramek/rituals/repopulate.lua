local data = {
	id = "repopulate",
	name = "repopulate",
	faction = "daramek",
	category = "rituals",
	rare = 4,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 7,
	back = true,
}

data.description = {
	"Sacrifice weakest ally",
	"Draw 3 allies",
}

data.ability={
	onPlay = function (card,game)
		local check
		for i,v in ipairs(game.my.play.cards) do
			if v.hp then 
				check = true
				break
			end
		end
		if not check then return end

		local candidate = {}
		local options = {unpack(game.my.deck.cards)}
		
		for i = #options,1,-1 do
			local v = options[i]
			if not v.hp then
				table.remove(options,i)
			end
		end

		for i = 1, 3 do
			if #options == 0 then break end
			table.insert(candidate,table.pickRandom(options)) 
		end

		for i,v in ipairs(candidate) do
			game:drawCard("my",v)
		end
		
		game:sacrificeCard("weakest") 
	
	end,
}

return data