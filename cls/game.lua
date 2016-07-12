local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(30)
game.font_content = love.graphics.newFont(20)

local Effect = require "cls/effect"
local Turn = require "cls/turn"

local sides = {"up","down"}
local hoverColor = {255,100,100,255}

function game:init()
	self.bg = require "cls/bg"("table2d")
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
	self.show = require "cls/show"(self)

	self.mousex = 0
	self.mousey = 0
	self.turnCount = 0
	self.cardPlayCount = 0
	self.effects = {}
	
	self.up.resource={
		gold = 30,
		food = 100,
		magic = 100,
		skull = 100,
		hp = 30
	}
	self.down.resource={
		gold = 30,
		food = 100,
		magic = 100,
		skull = 100,
		hp = 30
	}


	local upData = require "updata"
	local downData = require "downdata"
	self.up.deck:setCards(upData)
	self.up.library:setCards(upData)
	self.up.hero:setHero(upData)
	self.down.deck:setCards(downData)
	self.down.library:setCards(downData)
	self.down.hero:setHero(downData)
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

	self.show:update(dt)

	for i,e in ipairs(self.effects) do
		e:update(dt)
	end

	if self.hoverCard and self.click then
		self:clickCard()
	end

	if self.hoverCard and self.rightClick then
		self:showCard()
	end

	self.turnButton:update(dt)
end

function game:draw()

	self.bg:draw()
	self.turnButton:draw()

	for i,side in ipairs(sides) do
		
		self[side].hand:draw()
		self[side].bank:draw()
		self[side].play:draw()
		self[side].hero:draw()
		self[side].grave:draw()
		self[side].deck:draw()
	end

	

	self.show:draw()

	if self.hoverCard then
		self.hoverCard:draw(hoverColor)
	end

	for i,v in ipairs(self.effects) do
		v:draw()
	end
end


function game:gameStart()
	

	self.turn = "down"
	self.my = self.down
	self.your = self.up

	self.turnButton = require "cls/turn"(self,self.turn)

	for i = 1,4 do
		self:refillCard("up")
		self:refillCard("down")
	end
	for i = 1, 3 do
		self:drawCard("up")
		self:drawCard("down")
	end
	self:turnStart()
end


function game:turnStart()
	self.turnCount = self.turnCount + 1
	for i = 1, 3 do
		if #self.my.hand.cards>3 then break end
		self:drawCard()
	end
	self:refillCard()
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onTurnStart then card.ability.onTurnStart(card,self) end
	end
end

function game:turnEnd()
	for i,card in ipairs(self.my.play.cards) do
		if card.onTurnEnd then card.onTurnEnd(card,self) end
	end

	for i,card in ipairs(self.my.play.cards) do
		if card.last and type(card.last) == "number" then
			card.last = card.last - 1
			if card.last<1 then
				self:killCard(card)
			end
		end
	end

	self.turn = self.turn=="down" and "up" or "down"
	self.my = self.my == self.down and self.up or self.down
	self.your = self.your==self.up and self.down or self.up
	self:turnStart()
end


function game:clickCard()

	local current = self.hoverCard.current

	if #self.show.cards == 0 then
		if current == self.my.hand then
			self:playCard()
		elseif current == self.my.bank then
			self:buyCard()
		elseif current == self.my.play then
			self:feedCard()
		elseif current == self.my.hero then
			self:feedCard()
		elseif current == self.your.bank then
			self:robCard()
		elseif current == self.your.hand then
			self:stealCard()
		elseif current == self.your.play then
			self:attackCard()
		elseif current == self.your.hero then
			self:attackCard()
		end
	elseif #self.show.cards == 1 then
		if current == self.show then
			self:returnCard()
		end
	else
		if current == self.show then
			self:pickCard()
		end
	end
end

function game:showCard()
	local card = self.hoverCard
	for i,v in ipairs(self.show.cards) do
		if v then return end
	end
	self.show.lastPos = table.getIndex(card.current.cards,card)
	self.show.lastPlace= card.current
	self:transferCard(card,card.current,self.show)
end

function game:returnCard()
	local card = self.hoverCard
	local pos = self.show.lastPos
	local where = self.show.lastPlace
	self:transferCard(card,card.current,where,pos)
end


function game:robCard()
	if not self.canRob then return end
	local card = self.hoverCard
	if self.my.resource.gold < card.price then 
		print("too expensive")
		return 
	else
		self:lose(card,"my","gold",card.price)
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

function game:transferCard(card ,from,to ,pos,passResort)
	table.removeItem(from.cards, card)
	if from.resort and not passResort then from:resort() end
	if pos then
		table.insert(to.cards,pos, card )
	else
		table.insert(to.cards, card )
	end
	
	if to.resort and not passResort then to:resort() end
	card.current = to
end

function game:playCard()
	self.cardPlayCount = self.cardPlayCount + 1
	local card = self.hoverCard
	if card.last or card.hp then
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:transferCard(card,card.current,self.my.play)
	else
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:killCard(card)
		self:goback(card)
	end
end

function game:buyCard()
	local card = self.hoverCard
	if self.my.resource.gold + self.my.resource.magic < card.price then 
		print("too expensive")
		return 
	else

		for i = 1 , card.price-self.my.resource.gold do
			self:lose(card,"my","magic")
		end

		for i = 1, card.price do
			self:lose(card,"my","gold")
		end

		self:playCard(card)
	end

end

local res = {"gold","food","magic","skull"}

function game:gain(card,who,what)
	if what == "random" then what = res[love.math.random(#res)] end
	local res = self[who].resource
	res[what] = res[what] + 1
	
	local e = Effect(what,card,self.my.hero,false,1)
	e:addCallback(function() self[who].hero:updateResource()end)
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onGain then
			card.ability.onGain(card,self,who,what)
		end
	end
end

function game:lose(card,who,what)
	
	if what == "random" then 
		local candidate = {unpack(res)}
		repeat
			local index = love.math.random(#candidate)
			local item = candidate[index]
			if self[who].resource[item]>0 then
				what = item
				break
			else
				table.remove(candidate, index)
			end
		until #candidate == 0
		if what == "random" then return end
	end

	local res = self[who].resource
	res[what] = res[what] - 1
	
	local x,y
	if self.turn == "up" then
		x = self.my.hero.x -love.math.random(-30,30)
		y = self.my.hero.y +love.math.random(50,150)
	else
		x = self.my.hero.x +love.math.random(-30,30)
		y = self.my.hero.y -love.math.random(50,150)
	end
	local e = Effect(what,self[who].hero,{x=x,y=y},true,1,"outQuad")
	e:addCallback(function() self[who].hero:updateResource()end)	
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onLose then
			card.ability.onLose(card,self,who,what)
		end
	end
	return true
end

function game:feedCard()
	if self.my.resource.food <1 and self.my.resource.magic < 1 then return end
	local card = self.hoverCard
	if not card.hp and not card.isHero then return end
	if card.isHero then
		self.my.resource.hp = self.my.resource.hp+1
	else		
		if not card.ability.onFeed and card.hp == card.hp_max then return end
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
	end
	if self.my.resource.food > 0 then
		self.my.resource.food = self.my.resource.food - 1
		local x,y
		if self.turn == "up" then
			x = self.my.hero.x -love.math.random(-30,30)
			y = self.my.hero.y +love.math.random(100,150)
		else
			x = self.my.hero.x +love.math.random(-30,30)
			y = self.my.hero.y -love.math.random(100,150)
		end
		local out= Effect("food",self.my.hero,{x=x,y=y},false,0.3,"outQuad")
		out:addCallback(function() 
			local back = Effect("food",{x=x,y=y},self.my.hero,false,0.3,"inQuad")
			back:addCallback(function() self.my.hero:updateResource()end)
		end)
	else
		self.my.resource.magic = self.my.resource.magic - 1
		local x,y
		if self.turn == "up" then
			x = self.my.hero.x -love.math.random(-30,30)
			y = self.my.hero.y +love.math.random(100,150)
		else
			x = self.my.hero.x +love.math.random(-30,30)
			y = self.my.hero.y -love.math.random(100,150)
		end
		local out= Effect("magic",self.my.hero,{x=x,y=y},false,0.3,"outQuad")
		out:addCallback(function() 
			local back = Effect("magic",{x=x,y=y},self.my.hero,false,0.3,"inQuad")
			back:addCallback(function() self.my.hero:updateResource()end)
		end)
	end
	
	if card.ability.onFeed then card.ability.onFeed(card,self) end
	if self.my.hero.card.ability.onFeedAlly then 
		self.my.hero.card.ability.onFeedAlly(self.my.hero.card,self) 
	end

end

function game:attackCard()
	if self.my.resource.skull < 1 and self.my.resource.magic < 1 then return end
	local card = self.hoverCard
	if not card.hp and not card.isHero then return end
	
	if self.my.resource.skull > 0 then
		self.my.resource.skull = self.my.resource.skull - 1
	else
		self.my.resource.magic = self.my.resource.magic - 1
	end
	
	self:attack(self.my.hero.card,card)
end

function game:damageCard(card)
	if card.shield and card.shield>0 then
		card.shield = card.shield - 1
	else
		card.hp = card.hp - 1
	end

	if card.hp then
		if card.hp < 1 then return true end
	else
		if card.shield < 1 then return true end
	end

end

function game:killCard(card,passResort) 
	if card.back then
		self:transferCard(card ,card.current, card.born.deck ,_,passResort)
	else
		self:transferCard(card ,card.current, card.born.grave,_,passResort)
	end
end

function game:goback(card)

	if card.back then
		card.born.deck:goback(card)
	else
		card.born.grave:goback(card)
	end
end

function game:attack(from,to,ignore)
	if not from then from = self.my.hero.card end

	local yourCards = self.your.play.cards

	for i,card in ipairs(yourCards) do
		if card.cancel and card.cancel>0 then
			card.cancel = card.cancel -1
			Effect("attack",from,to,false,1,"inBack")
		end
	end

	local target
	local effect
	if #yourCards == 0 then 
		self:attackHero(from)
		return
	else
		local candidate={}
		for i,card in ipairs(yourCards) do
			if card.block and not ignore then
				table.insert(candidate, card)
			end
		end

		

		if #candidate == 0 then --no block
			if to then
				target = to
			else
				candidate = {unpack(yourCards)}
				target =candidate[love.math.random(1,#candidate)] 
			end
			effect = Effect("attack",from,target,false,1,"inBack")	
			effect:addCallback(function() target:vibrate() end)
			from:standout()

		else -- for blockers
			table.sort( candidate, function(a,b) return a.hp>b.hp end)
			target = candidate[1]
			if to then
				effect = Effect("attack",to,target,false,0.5,"inBack",true)
				local nextFunc = function()
					table.insert(self.effects, effect)
				end
				local shieldFunc = function()
					Effect("shield",to,to,false,0.5,"inBack")
				end
				local tmp = Effect("attack",from,to,false,0.5,"inBack")

				tmp:addCallback(function()target:standout() end)
				tmp:addCallback(shieldFunc)
				tmp:addCallback(nextFunc)
				from:standout()
			else
				effect = Effect("attack",from,target,false,0.5,"inBack")
				
				from:standout()
			end
		end

	
		if self:damageCard(target) then	 --killed	
			effect:addCallback(function() target:vibrate(_,_,
				function()
					self:goback(target)
					self.your.play:resort()
				end) end)
			self:killCard(target,true)
		else
			effect:addCallback(function() target:vibrate() end)
		end
	end

end


function game:attackHero(from)
	target = self.your.hero.card
	self.your.resource.hp = self.your.resource.hp -1
	local effect = Effect("attack",from,self.your.hero,false,1,"inBack" )
	effect:addCallback(function() target:vibrate() end)
	effect:addCallback(function() self.your.hero:updateResource()end)
	from:standout()
	if self.your.resource.hp < 0 then
		---game over!!
	end

end

return game


