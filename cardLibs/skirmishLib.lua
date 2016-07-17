local data = {
	faction = "vespitole",
	hero = "sofocatro",
	lib = {
			[1]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="serf",
			},
			[2]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="spiceroute",
			},
			[3]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="collecttaxes",
			},
			[4]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="vintner",
			},
			[5]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="wealthypatron",
			},
			[6]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="embargo",
			},
			[7]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="courtesan",
			},
			[8]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="courtlyintrigue",
			},
			[9]={
				["level"]=1,
				["exp"]=0,
				["category"]="war",
				["faction"]="vespitole",
				["id"]="militia",
			},
			[10]={
				["level"]=1,
				["exp"]=0,
				["category"]="faith",
				["faction"]="vespitole",
				["id"]="prayer",}
			},
	coins = {},
}

local function playHand(game)
	local card = game.my.hand.cards[1]
	if card then
		return game:playCard(card)
	end
end

local function feedAlly(game)
	for i,card in ipairs(game.my.play.cards) do
		if card.hp<card.hp_max then	
			return game:feedCard(card)
		end
	end
end


local function aimFoe(game)
	for i,card in ipairs(game.your.play.cards) do
		if card.hp then	
			return game:attackCard(card)
		end
	end
end

local function buyBank(game)
	for i,card in ipairs(game.my.bank.cards) do
		if game:buyCard(card) then return true end
	end
end

local function feedHero(game)
	if game.my.resource.hp < 10 then
		return game:feedCard(game.my.hero.card)
	end
end

local function attackHero(game)
	if game.your.resource.hp<= game.my.resource.skull + game.my.resource.magic then
		return game:attackCard(game.your.hero.card)
	end
end


data.rule = {playHand,feedAlly,aimFoe,buyBank,feedHero,attackHero}

return data