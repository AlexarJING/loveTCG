local data = {
	name = "coin",
	race = "green",
	class = "coin", --or 
	rare = 0 ,

	profile = {"no money, you can do nothing!"},

	level = 0,

	basePrice = 0,
	baseHp = 0,

	block = true,
	shield = 0,


	last = 0,
}

data.discription = {
	"Gold +1",
}

data.abilities={
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