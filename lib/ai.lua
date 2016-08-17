local ai = {}

function ai.chooseShow(game)
	if #game.show.cards==0 then return end
	if game.show.tag == "sibyllinescrolls" 
		or game.show.tag == ""
		then

	else


	end
	if card then
		return game:chooseCard(card)
	end
end


function ai.playHand(game)
	local card = game.my.hand.cards[1]
	if card then
		return game:playCard(card)
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
	for i,card in ipairs(game.my.bank.cards) do
		if game:buyCard(card) then return true end
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

function ai:getRule(data)
	local funcs={}
	for i,v in ipairs(data) do
		if not self[v] then error("no funcs") end
		table.insert(funcs, self[v])
	end
end

return ai