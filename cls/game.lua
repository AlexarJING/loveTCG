local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(40)
game.font_content = love.graphics.newFont(20)

local Effect = require "cls/effect"

local sides = {"up","down"}
local hoverColor = {255,100,100,255}

function game:init()
	self.bg = require "cls/bg"()
	self.up = {}
	self.down = {}
	for i,side in ipairs(sides) do
		self[side].deck = require "cls/deck"(self,side)
		self[side].hand = require "cls/hand"(self,side)
		self[side].bank = require "cls/bank"(self,side)
		self[side].play = require "cls/play"(self,side)
		self[side].library = require "cls/library"(self,side)
		self[side].hero = require "cls/hero"(self,side)
		self[side].grave = require "cls/grave"(self,side)
	end
	

	self.mousex = 0
	self.mousey = 0
	self.effects = {}
	self:gameStart()
end

function game:update(dt)
	self.hoverCard = nil
	for i,side in ipairs(sides) do
		self[side].deck:update(dt)
		self[side].hand:update(dt)
		self[side].bank:update(dt)
		self[side].play:update(dt)
		self[side].hero:update(dt)
		self[side].grave:update(dt)
	end

	for i,e in ipairs(self.effects) do
		e:update(dt)
	end

	if self.hoverCard and self.click then
		self:clickCard()
	end
end

function game:draw()

	self.bg:draw()
	for i,side in ipairs(sides) do
		self[side].deck:draw()
		self[side].hand:draw()
		self[side].bank:draw()
		self[side].play:draw()
		self[side].hero:draw()
		self[side].grave:draw()
	end

	for i,v in ipairs(self.effects) do
		v:draw()
	end

	if self.hoverCard then
		self.hoverCard:draw(hoverColor)
	end
end


function game:gameStart()
	self.up.resource={
		gold = 30,
		food = 0,
		magic = 0,
		skull = 0,
		hp = 30
	}
	self.down.resource={
		gold = 30,
		food = 0,
		magic = 0,
		skull = 0,
		hp = 30
	}

	self.down.hero:setHero(self.cardData.vespitole.captainviatrix)	
	self.up.hero:setHero(self.cardData.vespitole.captainviatrix)

	self.turn = "down"
	self.my = self.down
	self.your = self.up
	for i = 1,4 do
		self:refillCard("up")
		self:refillCard("down")
	end
	self:drawCard("my")
end


function game:turnStart()

end

function game:turnEnd()

end


function game:clickCard()
	local current = self.hoverCard.current
	if current == self.my.hand then
		self:playCard()
	elseif current == self.my.bank then
		self:buyCard()
	elseif current == self.my.play then
		self:feedCard()
	elseif current == self.my.hero then
		self:feedHero()
	elseif current == self.your.bank then
		self:robCard()
	elseif current == self.your.hand then
		self:stealCard()
	elseif current == self.your.play then
		self:attackCard(self.my.hero)
	elseif current == self.your.hero then
		self:attackHero()
	end
end

function game:robCard()
	if not self.canRob then return end
	local card = self.hoverCard
	if self.my.resource.gold < card.price then 
		print("too expensive")
		return 
	else
		self:lost(card,"my","gold",card.price)
		self:playCard(card)
	end
end

function game:stealCard()
	if not self.canSteal then return end
	local card = self.hoverCard
	self:transferCard(card,card.current,self.my.hand)
end


function game:drawCard(whose)
	whose = whose or "my"
	local from = self[whose].deck
	local index = love.math.random(#from.cards)
	local card = from.cards[index]
	local to = self[whose].hand
	self:transferCard(card,from,to)
end


function game:refillCard(whose)
	whose = whose or "my"
	local from = self[whose].library --data
	local index = love.math.random(#from.cards)
	local card = from:makeCard(from.cards[index])
	local to = self[whose].bank
	self:transferCard(card,from,to)
end

function game:transferCard(card ,from,to )
	table.removeItem(from.cards, card)
	if from.resort then from:resort() end
	table.insert(to.cards, card)
	if to.resort then to:resort() end
	card.current = to
end

function game:playCard()
	local card = self.hoverCard
	if card.last then
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:transferCard(card,card.current,self.my.play)
	else
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:transferCard(card,card.current,self.my.grave)
	end
end

function game:buyCard()
	local card = self.hoverCard
	if self.my.resource.gold < card.price then 
		print("too expensive")
		return 
	else
		self:lost(card,"my","gold",card.price)
		self:playCard(card)
	end

end


function game:gain(card,who,what,amount)
	local res = self[who].resource
	res[what] = res[what] + amount
	for i = 1, amount do
		Effect(what,card,self.my.hero,false,1)
	end
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onGain then
			card.ability.onGain(card,self,who,what,amount)
		end
	end
end

function game:lost(card,who,what,amount)
	local res = self[who].resource
	res[what] = res[what] - amount
	for i = 1, amount do
		local to={x=self.my.hero.x,y=0}
		Effect(what,self.my.hero,to,true,1,"outQuad")
	end
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onLost then
			card.ability.onLost(card,self,who,what,amount)
		end
	end
end

function game:feedCard()
	if self.my.resource.food <1 and self.my.resource.magic < 1 then return end
	local card = self.hoverCard
	if not card.hp then return end
	if not card.ability.onFeed and card.hp == card.hp_max then return end
	card.hp = card.hp + 1
	if self.my.resource.food > 0 then
		self.my.resource.food = self.my.resource.food - 1
	else
		self.my.resource.magic = self.my.resource.magic - 1
	end
	if card.hp>card.hp_max then card.hp = card.hp_max end
	if card.ability.onFeed then card.ability.onFeed(card,self) end

end

function game:attackCard()
	if self.my.resource.skull < 1 and self.my.resource.magic < 1 then return end
	local card = self.hoverCard
	if not card.hp then return end
	
	if self.my.resource.skull > 0 then
		self.my.resource.skull = self.my.resource.skull - 1
	else
		self.my.resource.magic = self.my.resource.magic - 1
	end
	
	self:attack(self.my.hero,card)
end

function game:testDeath(card)
	local death
	if card.hp then
		if card.hp < 1 then death = true end
	else
		if card.shield < 1 then death = true end
	end

	if death then
		if card.back then
			game:transferCard(card ,card.current, card.born )
		else

		end
		
	end
end

function game:attack(from,to)
	local yourCards = self.your.play.cards

	for i,card in ipairs(yourCards) do
		if card.cancel>0 then
			to.cancel = to.cancel -1
			Effect("skull",from,to,false,1,function() Effect("shield") end)
		end
	end

	if #yourCards == 0 then game:attackHero(from,to) end

	local candidate={}

	for i,card in ipairs(yourCards) do
		if card.block then
			table.insert(candidate, card)
		end
	end

	if #candidate == 0 then --no block
		candidate = {unpack(yourCards)}
		local target =candidate[love.math.random(#candidate)] 
		if targe.shield and target.shield>0 then
			target.shield = target.shield - 1
		else
			target.hp = target.hp - 1
		end

		if target.shield and target.shield<0 
	else -- for blockers
		table.sort( candidate, function(a,b) return a>b end)
	end

	

	


end

return game


