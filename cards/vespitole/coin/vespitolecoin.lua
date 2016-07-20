local data = {
	id = "vespitolecoin",
	name = "coin",
	faction = "vespitole",
	--category = "coin",
	rare = 0 ,

	profile = {"no money, you can do nothing!"},


	back = true,

	isCoin = true,
}

data.description = {
	"play: +1 gold",
}

data.ability={
	onBuy = function() end,
	onDraw = function() end,
	onHold = function() end,
	onPlay = function(card,game)
		game:gain(card,"my","gold",1)
	end,
	onPlayed = function() 	
	end,
	onDiscard = function() end,
	onKilled = function() end,
	onTurnStart = function() end,
	onTurnEnd = function() end,
	onAttack = function() end,
	onAttacked = function() end,
	onFeed = function() end,
	onGain = function() end,
	onHeal = function() end,
	onDamage = function() end,
	onDrawCard = function() end,
	onPlayCard = function() end,
	onBankRefill = function() end,
	onHandRefill = function() end,
}

return data