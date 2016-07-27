local data = {
	id = "culltheherd",
	name = "Cull the Herd",
	faction = "daramek",
	category = "rituals",
	rare = 2,
	profile = {" Find a pregnant sow. Have a dozen men scream at her until she is forced into early birth. Ferment each suckling in separate leather sacks, inscribed with the symbols 'haf', 'lem', 'peth', and 'kos'.  –Esra"},
	basePrice = 3,
	back = true,
}

data.description = {
	"Pick an ally to sacrifice",
 	"Gain random resources",
 	"equal to victim's life +1."
}

data.ability={
	onPlay = function (card,game)
		local candidate = {}
		if game:sacrificeCard("weakest") then
			local t = game:drawCard("my",function(c) return c.hp end,true)
			if t then table.insert(candidate,t) end
		end

		if #candidate == 0 then return end
		
		game:optionsCards(candidate)
	end,
}

return data