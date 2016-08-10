local data = {
	img_name = "culltheherd",
	name = "Cull the Herd",
	faction = "daramek",
	category = "rituals",
	rare = 2,
	profile = {" Find a pregnant sow. Have a dozen men scream at her until she is forced into early birth. Ferment each suckling in separate leather sacks, inscribed with the symbols 'haf', 'lem', 'peth', and 'kos'.  –Esra"},
	basePrice = 3,
	back = true,
}

data.description = {
	"Sacrifice weakest ally",
	"Draw 3 allies",
	"play one of them" 
}

data.ability={
	onPlay = function (card,game)
		local check
		for i,v in ipairs(game.my.play.cards) do
			if v.hp and not v.cannotScrifice then 
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

		
		game:sacrificeCard("weakest") 

		if #candidate == 0 then return end
		
		game:optionsCards(candidate)
	end,
}

return data