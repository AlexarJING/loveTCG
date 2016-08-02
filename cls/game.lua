local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(30)
game.font_content = love.graphics.newFont(20)

local Effect = require "cls/effect"
local Turn = require "cls/turn"
local Card = require "cls/card"

local sides = {"up","down"}
local hoverColor = {255,100,100,255}

local foeLibs={}
foeLibs[1] = require("cardLibs/skirmishLib")


function game:init(userdata,foedata)
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
	self.turnButton = require "cls/turn"(self)

	self.aiLevel = 1
	local foedata = foeLibs[self.aiLevel]

	self.aiCD = 0.5
	self.mousex = 0
	self.mousey = 0
	self.turnCount = 0
	self.cardPlayCount = 0
	self.effects = {}
	
	self.up.resource={
		gold = 0,
		food = 0,
		magic = 0,
		skull = 0,
	}
	self.down.resource={
		gold = 100,
		food = 0,
		magic =0,
		skull = 0,
	}

	self.up.turnDrawCount = 3
	self.up.handsize = 4
	self.down.turnDrawCount = 3
	self.down.handsize = 4


	self.userdata = userdata
	self.foedata = foedata

	self.up.deck:setCards(foedata)
	self.up.library:setCards(foedata)
	self.up.hero:setHero(foedata)
	self.down.deck:setCards(userdata)
	self.down.library:setCards(userdata)
	self.down.hero:setHero(userdata)
	self:gameStart()
end

function game:update(dt)
	delay:update(dt)
	self.hoverCard = nil
	
	if self.gameMode == "skirmish" and self.my ~= self.userside then
		self:AI(dt)
	end

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
		if self.my~=self.userside then return end
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

	if game.my.needTarget or game.your.needTarget then
		love.graphics.setFont(game.font_content)
		love.graphics.printf("select a target", -300, -50, 600, "center")
	end
end


function game:gameStart()
	
	self.gameMode = "skirmish"
	self.turn = "down"
	self.my = self.down
	self.your = self.up
	self.userside = self.down

	
	self.turnButton:setTurn(self.turn)

	for i = 1, 4 do
		self:refillCard("up")
		self:refillCard("down")
	end
	for i = 1, 3 do
		self:drawCard("up")
		self:drawCard("down")
	end
	self:turnStart()
end


function game:ally()
	return {self.my.hero.card,unpack(self.my.play.cards)}
end

function game:foe()
	return {self.your.hero.card,unpack(self.your.play.cards)}
end

function game:turnStart()
	self.turnCount = self.turnCount + 1
	
	local ally = self:ally()	

	for i,card in ipairs(ally) do
		if card.ability.onTurnPre then 	
			card.ability.onTurnPre(card,self)
		end
	end

	for i,card in ipairs(ally) do
		if card.ability.onTurnStart then 
			if not (card.undead and card.hp ==0) then ---undead
				card.ability.onTurnStart(card,self)
			end 
		end
	end

	for i,card in ipairs(ally) do
		if card.timer then 
			card.timer = card.timer - 1
			if card.timer<1 then
				card.ability:onTimeUp(card,self)
				self:killCard(card)
			end
		end 
	end

end

function game:turnEnd()

	local ally = self:ally()

	if #self.show.cards==1 then
		self:returnCard(self.show.cards[1])
	elseif #self.show.cards>1 then
		self:chooseCard(self.show.cards[1])
	end



	for i,card in ipairs(ally) do
		if card.onTurnEnd then card.onTurnEnd(card,self) end
	end


	for i,v in ipairs(ally) do
		if v.combo and self.comboCount<3 then
			self.comboCount = self.comboCount + 1
			self:killCard(v)
			self:turnStart()
			return
		end
	end

	self.comboCount = 0
	self.turn = self.turn=="down" and "up" or "down"
	self.my = self.my == self.down and self.up or self.down
	self.your = self.your==self.up and self.down or self.up

	if self.my.hero.ability.onDrawHand then
		self.my.hero.ability.onDrawHand(self)
	else
		for i = 1, self.my.turnDrawCount do
			if #self.my.hand.cards== self.my.handsize then break end
			self:drawCard()
		end
		self:refillCard()
	end
	
	for i,card in ipairs(ally) do
		if type(card.last) == "number" then
			card.last = card.last - 1
			card:updateCanvas()
			if card.last<1 then
				self:killCard(card)
			end
		end
	end

	
	self:turnStart()
end

function game:activateCard(card)
	if card.ability.onTurnStart then 
		if not (card.undead and card.hp ==0) then ---undead
			card.ability.onTurnStart(card,self)
		end 
	end
end


function game:clickCard()
	if self.my~=self.userside then return end
	local current = self.hoverCard.current
	
	if self.my.needTarget then
		if self.my.targetSelect(self,self.hoverCard) then self.my.needTarget= false end
	end

	local useall
	if love.keyboard.isDown("lshift") then
		useall = true
	else
		useall = false
	end
	if #self.show.cards == 0 then
		if current == self.my.hand then
			self:playCard()
		elseif current == self.my.bank then
			self:buyCard()
		elseif current == self.my.play or current == self.my.hero then
			if useall then
				self:feedCardAll(self.hoverCard)
			else
				self:feedCard()
			end		
		elseif current == self.your.bank then
			self:robCard()
		elseif current == self.your.hand then
			self:stealCard()
		elseif current == self.your.play  or current == self.your.hero then
			if useall then
				self:attackCardAll(self.hoverCard)
			else
				self:attackCard()
			end	
		end
	elseif current == self.show then
		if self.show.tag == "zoom" then
			self:returnCard()
		else
			self:chooseCard()
		end
	end
end

function game:showCard(card)
	card = card or self.hoverCard
	if self.show.cards[1] then return end

	self.show.lastPos = table.getIndex(card.current.cards,card)
	self.show.lastPlace= card.current
	self:transferCard(card,card.current,self.show)
	self.show.tag = "zoom"
end

function game:optionsCards(cards,to)
	if self.show.cards[1] then 
		--delay:new(delayTime,since,func,...)
		delay:new(
			function() return not self.show.cards[1] end,
			nil,
			function() 
				if self.my == self.userside then
					self:optionsCards(cards,to) 
				else
					game:chooseCard(cards[1])
				end
				
			end
			)
		return	
	end
	self.show.tag = "option"
	self.show.lastPlace = {}
	for i,v in ipairs(cards) do
		self.show.lastPlace[v] = v.current
	end

	for i,card in ipairs(cards) do
		self:transferCard(card,card.current,self.show)
	end
	self.show.targetPlace = to
end

function game:chooseCard(card)
	card = card or self.hoverCard
	self.show.tag = nil
	local cards = {unpack(self.show.cards)}
	
	for i,v in ipairs(cards) do
		if v==card then
			if self.show.onChoose then 
				self.show.onChoose(card,self)
				self.show.onChoose=nil
			else
				if self.show.targetPlace then
					self:transferCard(v,v.current,self.show.targetPlace)
				else
					self:playCard(v)
				end		
			end
		else
			self:transferCard(v,v.current,self.show.lastPlace[v])
		end
	end
	return true
end

function game:returnCard(card)
	card = card or self.hoverCard
	local pos = self.show.lastPos
	local where = self.show.lastPlace
	self.show.lastPos = nil
	self.show.lastPlace = nil
	self.show.tag = nil
	self:transferCard(card,card.current,where,pos)
end


function game:robCard(card)
	
	local robber

	for i,v in ipairs(self.my.play.cards) do
		if v.rob then
			robber = v
			break
		end
	end

	if not robber then return end

	card = card or self.hoverCard
	if self.my.resource.gold < card.price then 
		return 
	else
		self:killCard(robber)
		self:lose(card,"my","gold",card.price)
		self:playCard(card)
	end
end

function game:stealCard(card)
	if not self.canSteal then return end
	card = card or self.hoverCard
	self:transferCard(card,card.current,self.my.hand)
end


function game:drawCard(whose,id,manual) --or condition func with func(card)
	whose = whose or "my"
	local from = self[whose].deck
	if type(id) == "string" then
		for i,v in ipairs(self.my.deck.cards) do
			if v.id ==  id then
				v:reset()
				local to = self.my.hand
				self:transferCard(v,from,to)
				return
			end
		end
	elseif type(id) == "function" then
		
		local card = id(self.my.deck.cards)
		if card then
			card:reset()
			if manual then return v end
			local to = self.my.hand
			self:transferCard(card,from,to)
			return
		end
		
	else
		if #from.cards == 0 then return end
		local index = love.math.random(#from.cards)
		local card = from.cards[index]
		card:reset()
		local to = self.my.hand
		self:transferCard(card,from,to)
	end
	
end


function game:refillCard(whose,id,card)
	whose = whose or "my"
	local from = self[whose].library --data
	if type(id)=="string" then
		local d = self.cardData.short[id]
		d.level = card and card.level or 1
		local t = from:makeCard(v)
		local to = self[whose].bank
		self:transferCard(t,from,to)	
	elseif type(id) == "function" then
		local d = id(from.cards)
		if d then
			local t = from:makeCard(d)
			local to = self[whose].bank
			self:transferCard(t,from,to)
		end
	else
		local index = love.math.random(#from.cards)
		local t = from:makeCard(from.cards[index])
		--local card = from:makeCard(data)
		local to = self[whose].bank
		self:transferCard(t,from,to)
	end
end

function game:transferCard(card ,from,to ,pos,passResort)
	if from.cards then table.removeItem(from.cards, card) end
	if from.resort and not passResort then from:resort() end
	if pos then
		table.insert(to.cards,pos, card )
	else
		table.insert(to.cards, card )
	end
	if to.resort and not passResort then to:resort() end
	card.current = to
end

function game:playCard(card)
	card = card or self.hoverCard

	if card.charging then return end

	self.cardPlayCount = self.cardPlayCount + 1
	self.lastPlayed = card

	for i,v in ipairs(self.my.play.card) do
		if v.ability.onCardPlay then
			v.ability.onCardPlay(v,game,card)
		end
	end

	local hero = self.my.hero.card
	if hero.ability.onCardPlay then
		hero.ability.onCardPlay(v,game,card)
	end

	if card.last or card.hp then
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:transferCard(card,card.current,self.my.play)
	else
		local onPlay = card.ability.onPlay
		if onPlay then onPlay(card,self) end
		self:killCard(card)
	end
	
	
	return true
end

function game:buyCard(card)
	card = card or self.hoverCard
	self.lastBought = card
	if self.my.resource.gold + self.my.resource.magic < card.price then 
		return 
	else
		for i,v in ipairs(self.my.play.card) do
			if v.ability.onCardBuy then
				v.ability.onCardBuy(v,game,card)
			end
		end

		local hero = self.my.hero.card
		if hero.ability.onCardBuy then
			hero.ability.onCardBuy(hero,game,card)
		end


		for i,v in ipairs(self.your.play.card) do
			if v.ability.onFoeBuy then
				v.ability.onFoeBuy(v,game,card)
			end
		end

		local hero = self.your.hero.card
		if hero.ability.onFoeBuy then
			hero.ability.onFoeBuy(hero,game,card)
		end

		for i = 1 , card.price do
			if self.my.resource.gold>0 then
				self:lose(card,"my","gold")
			else
				self:lose(card,"my","magic")
			end			
		end

		if card.ability.onBuy then
			card.ability.onBuy(card,self)
		end

		if card.ability.onHold then
			self:transferCard(card,card.current,self.my.hand)
		else
			self:playCard(card)
		end
		return true
	end

end

local res = {"gold","food","magic","skull"}

function game:gain(card,who,what)
	if what == "random" then what = res[love.math.random(#res)] end

	if self.my.hero.card.ability.onGain then
		what = self.my.hero.card.ability.onGain(self.my.hero.card,self,who,what) or what
	end

	local res = self[who].resource
	res[what] = res[what] + 1
	
	local e = Effect(self,what,card,self.my.hero,false,1)
	e:addCallback(function() self[who].hero:updateResource()end)
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onGain then
			card.ability.onGain(card,self,who,what)
		end
	end
	
	if self.your.hero.card.ability.onGain then
		self.your.hero.card.ability.onGain(self.your.hero.card,self,who,what)
	end


	for i,card in ipairs(self.your.play.cards) do
		if card.ability.onFoeGain then
			card.ability.onFoeGain(card,self,who,what)
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
	local e = Effect(self,what,self[who].hero,{x=x,y=y},true,1,"outQuad")
	e:addCallback(function() self[who].hero:updateResource()end)	
	for i,card in ipairs(self.my.play.cards) do
		if card.ability.onLose then
			card.ability.onLose(card,self,who,what)
		end
	end
	return what
end

function game:feedCardAll()
	--delay:new(delayTime,since,func,...)
	if self.my.resource.food>0 then
		for i = 1, self.my.resource.food do
			delay:new(i*0.3,nil,self.feedCard,self)
			--self:feedCard()
		end
	elseif self.my.resource.magic>0 then
		for i = 1, self.my.resource.magic do
			delay:new(i*0.3,nil,self.feedCard,self)
		end
	end
end

function game:attackCardAll(target)
	if self.my.resource.skull>0 then
		for i = 1, self.my.resource.skull do
			delay:new(i*0.1,nil,self.attackCard,self,target)
			--self:attackCard()
		end
	elseif self.my.resource.magic>0 then
		for i = 1, self.my.resource.magic do
			delay:new(i*0.1,nil,self.attackCard,self,target)
		end
	end
end

function game:feedHeroWith(what)
	local card = self.my.hero.card
	self.my.resource.hp = self.my.resource.hp+1
	card:updateCanvas()
	for i,v in ipairs(self.my.play.cards) do
		if v.ability.onFeedMagic then v.ability.onFeedMagic(card,game) end
	end
	if card.ability.onFeed then card.ability.onFeed(card,self,what) end	
	return true
end

function game:feedCardGold(card)
	if self.my.resource.gold <1 then return end
	self:lose(self.my.hero.card,"my","gold")
	if card.ability.onFeed then card.ability.onFeed(card,self) end
	
	for i,v in ipairs(self.my.play.cards) do
		v.ability.onFeedAlly(v,self) 
	end

	if self.my.hero.card.ability.onFeedAlly then 
		self.my.hero.card.ability.onFeedAlly(self.my.hero.card,self) 
	end
	return true
end

function game:feedCardMagic(card)
	if self.my.resource.magic <1 then return end
	if card.awaken == false then
		card.awaken = true
		card.ability.onAwake(card,self)
	end
	self:lose(self.my.hero.card,"my","gold")
	if card.ability.onFeed then card.ability.onFeed(card,self) end
	
	for i,v in ipairs(self.my.play.cards) do
		v.ability.onFeedAlly(v,self) 
	end

	if self.my.hero.card.ability.onFeedAlly then 
		self.my.hero.card.ability.onFeedAlly(self.my.hero.card,self) 
	end
end

function game:feedCardLife(card)
	if self.my.resource.hp <1 then return end
	self:lose(self.my.hero.card,"my","hp")
	self:healCard(card)
	if card.ability.onFeed then card.ability.onFeed(card,self) end
	
	for i,v in ipairs(self.my.play.cards) do
		v.ability.onFeedAlly(v,self) 
	end

	if self.my.hero.card.ability.onFeedAlly then 
		self.my.hero.card.ability.onFeedAlly(self.my.hero.card,self) 
	end
	return true
end


function game:feedCard(card)
	if card.canFeedGold then return self:feedCardGold(card) end
	if card.canFeedMagic then return self:feedCardMagic(card) end
	if card.canFeedLife then return self:feedCardLife(card) end

	if self.my.resource.food <1 and self.my.resource.magic < 1 then return end
	card = card or self.hoverCard
	if not card.hp and not card.isHero then return end
	if card.isHero then
		self.my.resource.hp = self.my.resource.hp+1
	else		
		if not card.ability.onFeed and card.hp == card.hp_max then return end
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
	end
	card:updateCanvas()
	if self.my.resource.food > 0 then
		self:lose(self.my.hero.card,"my","food") --game:lose(card,who,what)
	else
		self:lose(self.my.hero.card,"my","magic")

	end
	



	if card.ability.onFeed then card.ability.onFeed(card,self) end
	if self.my.hero.card.ability.onFeedAlly then 
		self.my.hero.card.ability.onFeedAlly(self.my.hero.card,self,card) 
	end
	for i,v in ipairs(self.my.play.cards) do
		v.ability.onFeedAlly(v,self,card) 
	end
	return true
end




function game:healCard(card)
	if card.isHero then
		self.my.resource.hp = self.my.resource.hp + 1
	elseif card then
		if not card.hp then return end
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
	else

		local lowest 
		local value = 100
		for i,v in ipairs(self.my.play.cards) do
			if v.hp and v.hp_max-v.hp>0 and v.hp<value then 
				lowest = {v}
				value = v.hp
			elseif v.hp and v.hp_max-v.hp>0 and v.hp==value then 
				table.insert(lowest,v)
			end
		end

		if not lowest then 
			self.my.resource.hp = self.my.resource.hp + 1
			return 
		end

		local card = table.random(lowest)
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
	end
end

function game:healAll()
	for i,v in ipairs(self.my.play.cards) do
		self:healCard(v)
	end
	self:healCard(self.my.hero.card)
end

function game:attackCard(card)
	if self.my.resource.skull < 1 and self.my.resource.magic < 1 then return end
	card = card or self.hoverCard
	if not card.hp and not card.isHero then return end
	
	if self.my.resource.skull > 0 then
		self.my.resource.skull = self.my.resource.skull - 1
	else
		self.my.resource.magic = self.my.resource.magic - 1
	end
	self.my.hero:updateResource()
	self:attack(self.my.hero.card,card)
	return true
end

function game:damageCard(card)
	if card.charge and card.charge>0 then
		card.charge = card.charge - 1
	else
		card.hp = card.hp - 1
	end
	card:updateCanvas()
	if card.hp then
		if card.hp < 1 and not card.undead then 
			card.hp = 0
			if card.onDying then 
				return card.onDying(card,self)
			end
			return "death"
		end
	else
		if card.charge < 1 then return "death" end
	end

end

function game:killCard(card,passResort)
	if card.current == self.my.bank or card.current == self.your.bank then 
		self:transferCard(card ,card.current, card.born.grave,_,passResort) 
	end

	if card.current == self.my.hand or card.current == self.your.hand then 
		self:transferCard(card ,card.current, card.born.grave,_,passResort) 
	end
--------------------------------------------------
	
	if card:getSide() == self.my then 
		for i,v in ipairs(self.my.play.cards) do
			if v.ability.onAllyDie then
				v.ability.onAllyDie(v,self,card)
			end
		end
		for i,v in ipairs(self.my.play.cards) do
			if v.ability.onFoeDie then
				v.ability.onFoeDie(v,self,card)
			end
		end
	else
		for i,v in ipairs(self.my.play.cards) do
			if v.ability.onFoeDie then
				v.ability.onFoeDie(v,self,card)
			end
		end
		for i,v in ipairs(self.my.play.cards) do
			if v.ability.onAllyDie then
				v.ability.onAllyDie(v,self,card)
			end
		end
	end
	


	if card.ability.onKilled then 
		if card.ability.onKilled(card,self) then --directly kill
			self:transferCard(card ,card.current, card.born.grave,_,passResort)
			return
		end
	end

	for i,v in ipairs(self.my.play.cards) do
		if v.ability.onKillCard and v.ability.onKillCard(v,self,card) then	
			return
		end
	end
	
	if card.back then
		self:transferCard(card ,card.current, card.born.deck ,_,passResort)
	else --destroy
		if card.ability.onDestoryed then
			if card.ability.onDestoryed(card,self) then
				self:transferCard(card ,card.current, card.born.deck ,_,passResort)
				return
			end
		end

		for i,v in ipairs(self.my.play.cards) do
			if v.ability.onDestroyCard then
				if v.ability.onDestroyCard(v,self,card) then
					self:transferCard(card ,card.current, card.born.deck ,_,passResort)
					return
				end
			end
		end

		local check = self.my.hero.card.ability.onDestroyCard
		if check then
			if check(self.my.hero.card,self,card) then
				self:transferCard(card ,card.current, card.born.deck ,_,passResort)
			end
		end

		for i,v in ipairs(self.my.play.cards) do
			if v.instead then
				self:transferCard(card ,card.current, card.born.deck ,_,passResort)
				self:killCard(v)
				return
			end
		end
		self:transferCard(card ,card.current, card.born.grave,_,passResort)
	end
end

function game:destroyCard(card,passResort)
	if card.ability.onKilled then 
		if card.ability.onKilled(card,self) then --directly kill
			self:transferCard(card ,card.current, card.born.grave,_,passResort)
			return
		end
	end

	for i,v in ipairs(self.my.play.cards) do
		if v.ability.onKillCard and v.ability.onKillCard(v,self,card) then	
			return
		end
	end
	
	
	if card.ability.onDestoryed then
		if card.ability.onDestoryed(card,self) then
			self:transferCard(card ,card.current, card.born.deck ,_,passResort)
			return
		end
	end

	for i,v in ipairs(self.my.play.cards) do
		if v.ability.onDestroyCard then
			if v.ability.onDestroyCard(v,self,card) then
				self:transferCard(card ,card.current, card.born.deck ,_,passResort)
				return
			end
		end
	end

	local check = self.my.hero.card.ability.onDestroyCard
	if check then
		if check(self.my.hero.card,self,card) then
			self:transferCard(card ,card.current, card.born.deck ,_,passResort)
		end
	end

	for i,v in ipairs(self.my.play.cards) do
		if v.instead then
			self:transferCard(card ,card.current, card.born.deck ,_,passResort)
			self:killCard(v)
			return
		end
	end
	self:transferCard(card ,card.current, card.born.grave,_,passResort)
	
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
	local my,your
	if from.current == self.my.play then 
		my = self.my
		your = self.your
	else
		my = self.your
		your = self.my
	end

	if to == "self" then
		local tmp = your
		your = my
		my = tmp
	end

	local yourCards = your.play.cards

	for i,card in ipairs(yourCards) do
		if card.ability.onAnyAttack then
			card.ability.onAnyAttack(card,self,from)
		end
	end

	for i,card in ipairs(yourCards) do
		if card.cancel and card.cancel>0 then
			card.cancel = card.cancel -1
			Effect(self,"attack",from,card,false,1,"inBack")
			return
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
			if card.intercept and not ignore then
				table.insert(candidate, card)
			end
		end

		

		if #candidate == 0 then --no block
			if type(to) == "table" then
				target = to
			
			elseif to == "weakest" then

				local weakest
				local weakest_hp = 10
				for i,v in ipairs(my.play.cards) do
					if v.hp and v.hp<weakest_hp then
						weakest = {v}
						weakest_hp = v.hp
					elseif v.hp and v.hp== weakest_hp then
						table.insert(weakest,v)
					end
				end
				
				if weakest then
					target = weakest[love.math.random(#weakest)]
				else
					target = your.hero.card
				end
				
			elseif to == "hero" then
				target = your.hero.card
			else
				for i,v in ipairs(yourCards) do
					if v.hp or v.charge then
						table.insert(candidate, v)
					end
				end

				if #candidate == 0 then
					self:attackHero(from)
					return
				end

				target =candidate[love.math.random(1,#candidate)] 
			end
			effect = Effect(self,"attack",from,target,false,1,"inBack")	
			effect:addCallback(function() target:vibrate() end)
			from:standout()

		else -- for blockers
			local strongest
			local strongest_value = 0
			for i,v in ipairs(my.play.cards) do
				if (v.hp and v.hp>strongest_value) or (v.charge and v.charge>strongest_value) then
					strongest = {v}
					strongest_value = v.hp
				elseif (v.hp and v.hp== strongest_value) or (v.charge and v.charge == strongest_value) then
					table.insert(strongest,v)
				end
			end
			
			if strongest then
				target = table.random(strongest)
			else
				error("check intercept")
			end

			if to then
				effect = Effect(self,"attack",to,target,false,0.5,"inBack",true)
				local nextFunc = function()
					table.insert(self.effects, effect)
				end
				local shieldFunc = function()
					Effect(self,"shield",to,to,false,0.5,"inBack")
				end
				local tmp = Effect(self,"attack",from,to,false,0.5,"inBack")

				tmp:addCallback(function()target:standout() end)
				tmp:addCallback(shieldFunc)
				tmp:addCallback(nextFunc)
				from:standout()
			else
				effect = Effect(self,"attack",from,target,false,0.5,"inBack")
				
				from:standout()
			end
		end

		if from == my.hero.card then
			for i,v in ipairs(my.play.cards) do
				if v.ability.onHeroAttack then
					v.ability.onHeroAttack(v,game)
				end
			end
		end

		if target.dodgeRate and love.math.random()<target.dodgeRate then
			effect:addCallback(function() target:turnaround() end)
			return
		end

		local foe = {your.hero.card,unpack(your.play.cards)}
		for i,v in ipairs(foe) do
			if v.ability.onFoeAttack then
				local t = v.ability.onFoeAttack(v,self,target)
				if t then
					target = t
					break
				end
			end
		end


		local result = self:damageCard(target)

		if result == "death" then	 --killed	
			effect:addCallback(function() target:vibrate(_,_,
				function()
					--self:goback(target)
					your.deck:resort()
					your.play:resort()
				end) end)
			self:killCard(target,true)
		elseif result == "toHand" then
			self:transferCard(target ,target.current, target.my.hand ,_,true)
			effect:addCallback(function() target:vibrate(_,_,
				function()
					my.hand:resort()
				end)
			end)
		else
			effect:addCallback(function() target:vibrate() end)
		end
	end

end


function game:attackHero(from)
	local my,your
	if from.current == self.my.play then 
		my = self.my
		your = self.your
	else
		my = self.your
		your = self.my
	end

	target = your.hero.card
	your.resource.hp = your.resource.hp -1
	local effect = Effect(self,"attack",from,your.hero,false,1,"inBack" )
	effect:addCallback(function() target:vibrate() end)
	effect:addCallback(
		function() 
			your.hero:updateResource()
			if your.resource.hp < 1 then
				for i,v in ipairs(your.play.cards) do
					if v.ability.onHeroAttacked then
						v.ability.onHeroAttacked(v,self,from)
					end
				end
				if game.userside == your then
					self:loser()
				else
					self:winner()
				end
			end
		end)
	from:standout()
end

function game:winner()
	--screenshot,hero,result
	local ss = love.graphics.newImage(love.graphics.newScreenshot())
	gamestate.switch(gameState.result_scene,ss,self.my.hero.card,"win",self)
end

function game:loser()
	--screenshot,hero,result
	local ss = love.graphics.newImage(love.graphics.newScreenshot())
	gamestate.switch(gameState.result_scene,ss,self.my.hero.card,"lose",self)
end



function game:sacrificeCard(target)
	if #self.my.play.cards==0 and type(target)~="table" then return end
	if target == "weakest" then
		for i,v in ipairs(self.my.play.cards) do
			if v.sacrifice then
				if v.ability.onSacrifice then v.ability.onSacrifice(v,self) end
				self:killCard(v)
				return v
			end
		end
		local weakest
		local weakest_hp = 10
		for i,v in ipairs(self.my.play.cards) do
			if v.hp and not v.cannotScrificed and v.hp<weakest_hp then
				weakest = {v}
				weakest_hp = v.hp
			elseif v.hp and not v.cannotScrificed and v.hp== weakest then
				table.insert(weakest,v)
			end
		end
		if not weakest then return end
		local card = weakest[love.math.random(#weakest)]
		for i,v in ipairs({self.my.hero.card,unpack(self.my.play.cards)}) do
			if v.onSacrificeAlly then
				v.onSacrificeAlly(v,game,card)
			end
		end
		if card.ability.onSacrifice then card.ability.onSacrifice(card,self) end
		self:killCard(card)
		return card
	elseif target == "strongest" then
		for i,v in ipairs(self.my.play.cards) do
			if v.sacrifice then
				if v.ability.onSacrifice then v.ability.onSacrifice(v,self) end
				self:killCard(v)
				return v
			end
		end
		local strongest
		local strongest_hp = 0
		for i,v in ipairs(self.my.play.cards) do
			if v.hp and not v.cannotScrificed and v.hp>strongest_hp then
				strongest = {v}
				strongest_hp = v.hp
			elseif v.hp and not v.cannotScrificed  and v.hp== strongest then
				table.insert(strongest,v)
			end
		end
		if not strongest then return end
		local card = strongest[love.math.random(#strongest)]
		for i,v in ipairs(({self.my.hero.card,unpack(self.my.play.cards)})) do
			if v.onSacrificeAlly then
				v.onSacrificeAlly(v,game,card)
			end
		end
		if card.ability.onSacrifice then card.ability.onSacrifice(card,self) end
		self:killCard(card)
		return card
	elseif target == "random" then
		for i,v in ipairs(self.my.play.cards) do
			if v.sacrifice then
				if v.ability.onSacrifice then v.ability.onSacrifice(v,self) end
				self:killCard(v)
				return v
			end
		end
		local candidate = {}
		for i,v in ipairs(self.my.play.cards) do	
			if v.hp and not v.cannotScrificed then
				table.insert(candidate,v)
			end
		end	
		local card = candidate[love.math.random(#candidate)]
		for i,v in ipairs(({self.my.hero.card,unpack(self.my.play.cards)})) do
			if v.onSacrificeAlly then
				v.onSacrificeAlly(v,game,card)
			end
		end
		if card.ability.onSacrifice then card.ability.onSacrifice(card,self) end
		self:killCard(card)
		return card
	elseif type(target)=="string" then
		for i,v in ipairs(self.my.play.cards) do
			if v.id == target then
				for i,t in ipairs(({self.my.hero.card,unpack(self.my.play.cards)})) do
					if t.onSacrificeAlly then
						t.onSacrificeAlly(t,game,card,v)
					end
				end
				if v.ability.onSacrifice then v.ability.onSacrifice(v,self) end
				self:killCard(v)
				return v
			end
		end
	elseif type(target)=="table" then
		for i,v in ipairs({self.my.hero.card,unpack(self.my.play.cards)}) do
			if v.onSacrificeAlly then
				v.onSacrificeAlly(v,game,target)
			end
		end
		if target.ability.onSacrifice then target.ability.onSacrifice(target,self) end
		
		self:killCard(target)
	else
		local candidate = {}
		for i,v in ipairs({self.my.hero.card,unpack(self.my.play.cards)}) do
			if v.hp and not v.cannotScrificed then table.insert(candidate,v) end
		end
		if not candidate[1] then return end
		local c = candidate[love.math.random(#candidate)]
		for i,v in ipairs(self.my.play.cards) do
			if v.onSacrificeAlly then
				v.onSacrificeAlly(v,game,c)
			end
		end
		if c.ability.onSacrifice then c.ability.onSacrifice(c,self) end
		self:killCard(c)
		return c
	end
end

function game:copyCard(card)
	--card:init(game,data,born,current)
	return Card(self,card.data,card.born,card.current)
end

function game:chargeCard(card,cond)
	if not card.charge then return end
	if card == "random" then
		local candidate = {}
		for i,v in ipairs(self.my.play.cards) do
			if cond and v.category == cond then
				table.insert(candidate)
			elseif not cond then
				table.insert(candidate)
			end
		end
		for i,v in ipairs(self.my.hand.cards) do
			if cond and v.category == cond then
				table.insert(candidate)
			elseif not cond then
				table.insert(candidate)
			end
		end
		return	self:chargeCard(table.random(candidate))
	elseif card =="all" then
		for i,v in ipairs(self.my.play.cards) do
			self:chargeCard(v)
		end
		for i,v in ipairs(self.my.hand.cards) do
			self:chargeCard(v)
		end
		return
	end

	card.charge = card.charge+1
	card:updateCanvas()
	if card.charge >= card.chargeMax then
		card.ability.onFullCharge(card,self)
		card.charge = card.chargeMax
	end
end

function game:dischargeCard(card)
	card.charge = card.charge-1
	card:updateCanvas()
	if card.charge <= 0 then
		card.charge = 0
		if card.awaken == nil then
			self:killCard(card)
		elseif card.awaken ==true then
			card.awaken = false
			card.ability.onSleep(card,self) 
		end
	end
end

function game:summon(id)
	local data = game.cardData.short[id]
	local c = game.my.library:makeCard(data)
	game:transferCard(c,c.current,game.my.play)
end

function game:AI(dt)
	if self.aiEnd then return end
	self.aiCD = self.aiCD - dt
	if self.aiCD > 0 then return end
	local rule = self.foedata.rule
	for i,cond in ipairs(rule) do
		if cond(self) then
			self.aiCD = 0.5
			return 
		end
	end

	delay:new(3,nil,function() 
		self.turnButton:endturn()
		self.aiCD = 0.5
		self.aiEnd=false
	end)
	self.aiEnd=true
end

return game


