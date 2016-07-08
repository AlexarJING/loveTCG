local data = {
	id = "captainviatrix",
	name = "viatrix",
	race = "vespitole",
	class = "hero", --or 

	profile = {"no money, you can do nothing!"},

	isHero = true,

}

data.description = {
	"turn: +1 Food",
}

data.ability={
	onBuy = function() end,
	onDraw = function() end,
	onHold = function() end,
	onPlay = function() 
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