local ai = {}

function ai.chooseShow(game)
	if #game.show.cards==0 then return end
	local card = table.max(game.show.cards,"price")
	if card then
		return game:chooseCard(card)
	end
end

function ai.supplyTarget(game)
	if not game.my.needTarget then return end
	local foe = table.combine(game.your.play.cards,game.your.hand.cards,game.your.bank.cards)
	local target = table.max(foe,"price")
	if target then
		local result = game.my.targetSelected(game,target)
		if result then
			game.my.needTarget= false
			return true
		end 
	end
end

--如果有不能出的则留不能出的 charging
--如果有onhold则留最贵的
--贵的牌先出
--手里最多留一个能出的牌，


function ai.playHand(game)
	local hold
	local cards = {unpack(game.my.hand.cards)}

	for i,v in ipairs(cards) do
		if v.charging then 
			hold = v 
		elseif v.ability.onHold then
			if (not v.chargeMax) or (v.chargeMax and v.charge<v.chargeMax) then
				if not hold then
					hold = v
				elseif v.price>hold.price then
					hold = v
				end
			end
		end
	end

	table.removeItem(cards,hold)

	local target = table.max(cards,"price")

	if target then return game:playCard(target) end

	for i,v in ipairs(cards) do
		local rt = game:playCard(v)
		if rt then return rt end
	end

end

function ai.feedAlly(game)
	for i,card in ipairs(game.my.play.cards) do
		if card.hp and card.hp<card.hp_max then	
			return game:feedCard(card)
		end
	end
end


function ai.aimFoe(game)

	for i,card in ipairs(game.your.play.cards) do
		if card.hp then	
			return game:attackCard(card)
		end
	end
end

function ai.buyBank(game)
	for i,card in ipairs(game.your.bank.cards) do
		local rt = game:robCard(card)
		if rt then return true end
	end

	for i,card in ipairs(game.my.bank.cards) do
		local rt = game:buyCard(card)
		if rt then return true end
	end
end

function ai.feedHero(game)
	if game.my.resource.hp < 10 then
		return game:feedCard(game.my.hero.card)
	end
end

function ai.attackHero(game)
	if game.your.resource.hp<= game.my.resource.skull + game.my.resource.magic then
		return game:attackCard(game.your.hero.card)
	end
end

local default = {"chooseShow","supplyTarget","playHand","feedAlly","aimFoe","buyBank","feedHero","attackHero"}

function ai:getRule(data,aifuncs)
	local funcs={}
	for i,v in ipairs(data or default) do
		if self[v] then
			table.insert(funcs, self[v])
		else 
			if aifuncs and aifuncs[v] then
				table.insert(funcs, aifuncs[v])
			end
		end
			
	end
	return funcs
end

return ai