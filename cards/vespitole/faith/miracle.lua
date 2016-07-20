local data = {
	id = "miracle",
	name = "Miracle",
	faction = "vespitole",

	category = "faith",
	
	rare = 4 ,

	profile = {" It's not witchcraft when God does it. –Cardinal Pocchi"},

	basePrice = 13,

	back = true,
}

data.description = {
	"play: draw a random card",
}

data.ability={
	onPlay = function(card,game) 
		local lib = game.cardData.index
		local target
		repeat
			target = lib[love.math.random(#lib)]
		until not target.isHero
		local tCard = game.my.library:makeCard(target)
		game:transferCard(tCard,{},game.my.hand) --card ,from,to 
	end,
}

return data