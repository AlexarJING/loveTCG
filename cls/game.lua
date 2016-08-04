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
	self.debug = require "cls/debug"(self)
	self.console = require "cls/console"(self,-640,360,1280,300)
	self.cursor = require "cls/cursor"(self)

	self.console.cmd.endturn = function()
		self:endturn()
	end

	self.aiLevel = 1
	
	local foedata = foeLibs[self.aiLevel]  ---todo！！！

	self.aiCD = 0.5
	self.mousex = 0
	self.mousey = 0
	self.turnCount = 0
	self.cardPlayCount = 0
	self.effects = {}
	
	

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
	
	self.up.resource=self.up.hero.card
	self.down.resource=self.down.hero.card

	self.aiToggle = true

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

	self.debug:update(dt)
	self.show:update(dt)

	for i,e in ipairs(self.effects) do
		e:update(dt)
	end

	if self.hoverCard and self.click then
		if self.hoverCard.current == self.debug then 
			self.debug:click(self.hoverCard)
			return 
		end
		self:clickCard()
	end

	if self.hoverCard and self.rightClick then
		if self.my~=self.userside then return end
		if self.hoverCard.current == self.debug then 
			self.debug:rightClick(self.hoverCard)
			return 
		end
		self:showCard(self.hoverCard)
	end

	self.hover = self.turnButton:update(dt) or self.hoverCard
	self.cursor:update(self.hover)
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

	self.debug:draw()

	self.show:draw()

	if self.hoverCard then
		self.hoverCard:draw(hoverColor)
	end

	for i,v in ipairs(self.effects) do
		v:draw()
	end

	if self.my.needTarget or self.your.needTarget then
		love.graphics.setFont(self.font_content)
		love.graphics.printf("select a target", -300, -50, 600, "center")
	end

	self.console:draw()

	if self.aiToggle then 
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.setFont(self.font_content)
		love.graphics.print("AI: on", -640,-320)
	else
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.setFont(self.font_content)
		love.graphics.print("AI: off", -640,-320)
	end

	self.cursor:draw()
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

function game:endturn()
	self.turnButton:endturn()
end


function game:ally(card)
	if not card then return {self.my.hero.card,unpack(self.my.play.cards)} end
	if card.current == self.my.play or card.current == self.my.hero then
		return {self.my.hero.card,unpack(self.my.play.cards)}
	else
		return {self.your.hero.card,unpack(self.your.play.cards)}
	end
end

function game:foe(card)
	if not card then return {self.your.hero.card,unpack(self.your.play.cards)} end
	if card.current == self.my.play or card.current == self.my.hero then
		return {self.your.hero.card,unpack(self.your.play.cards)}
	else
		return {self.my.hero.card,unpack(self.my.play.cards)}
	end

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

	if self.my.hero.card.ability.onDrawHand then
		self.my.hero.card.ability.onDrawHand(self)
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

function game:textinput(t)
	self.console:textinput(t)
end

function game:keypress(key)
	self.console:keypressed(key)
	if self.keyLock then return end
	if self.my~=self.userside and self.aiToggle then return end
	if key == "space" then
		self.turnButton:endturn()
	elseif key == "f1" then
		self.debug.enable = not self.debug.enable
		self.my.hero.card.gold = 999
		self.my.hero.card.food = 999
		self.my.hero.card.magic = 999
		self.my.hero.card.skull = 999
	elseif key == "f2" then
		self.console:toggle(not self.console.enable)
	elseif key == "f3" then
		self.aiToggle = not self.aiToggle
	end
end

function game:mousepressed(key)
	self.console:mousepressed(key)
	if self.keyLock then return end
	if key == 1 then
		self.click = true
	else 
		self.rightClick = true
	end
end

function game:clickCard()
	if self.my~=self.userside and  self.aiToggle then return end

	local current = self.hoverCard.current
	local card = self.hoverCard

	if self.my.needTarget and self.my.targetSelect(self,self.hoverCard) then
		self.my.needTarget= false 
	end

	local useall
	if love.keyboard.isDown("lshift") then
		useall = true
	else
		useall = false
	end

	if #self.show.cards == 0 then
		if current == self.my.hand then
			self:playCard(card)
		elseif current == self.my.bank then
			self:buyCard(card)
		elseif current == self.my.play or current == self.my.hero then
			if useall then
				self:feedCard(card,"all")
			else
				self:feedCard(card)
			end		
		elseif current == self.your.bank then
			self:robCard(card)
		elseif current == self.your.hand then
			self:stealCard(card)
		elseif current == self.your.play  or current == self.your.hero then
			if useall then
				self:attackCard(card,"all")
			else
				self:attackCard(card)
			end	
		end
	elseif current == self.show then
		if self.show.tag == "zoom" then
			self:returnCard(card)
		else
			self:chooseCard(card)
		end
	end
end

function game:showCard(card)

	if self.show.cards[1] then return end

	self.show.lastPos = table.getIndex(card.current.cards,card)
	self.show.lastPlace= card.current
	self:transferCard(card,self.show)
	self.show.tag = "zoom"
end

function game:optionsCards(cards,to)
	if self.show.cards[1] then 
		--delay:new(delayTime,since,func,...)
		delay:new(
			function() return not self.show.cards[1] end, --condition
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
		self:transferCard(card,self.show)
	end
	self.show.targetPlace = to
end

function game:chooseCard(card)

	self.show.tag = nil
	local cards = {unpack(self.show.cards)}
	for i,v in ipairs(cards) do
		if v==card then
			if self.show.onChoose then 
				self.show.onChoose(card,self)
				self.show.onChoose=nil
			else
				if self.show.targetPlace then
					self:transferCard(v,self.show.targetPlace)
				else
					self:playCard(v)
				end		
			end
		else
			self:transferCard(v,self.show.lastPlace[v])
		end
	end
	return true
end

function game:returnCard(card)

	local pos = self.show.lastPos
	local where = self.show.lastPlace
	self.show.lastPos = nil
	self.show.lastPlace = nil
	self.show.tag = nil
	self:transferCard(card,where,pos)
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

	if self:buyCard(card) then
		self:killCard(robber)
		return true
	end
end

function game:stealCard(card)
	if not self.canSteal then return end
	card = card or self.hoverCard
	self:transferCard(card,self.my.hand)
end


function game:drawCard(whose,id,manual) --or condition func with func(card)
	whose = whose or "my"
	local to = self.my.hand

	if whose == "up" or whose == "down" then
		to = self[whose].hand
	end

	if type(id) == "string" then  ---当id为名字时
		for i,v in ipairs(self[whose].deck.cards) do
			if v.id ==  id then
				v:reset()
				self:transferCard(v,to)
				return v
			end
		end
	elseif type(id) == "function" then --id 为条件时 返回真则抓牌
		
		local card = id(self[whose].deck.cards)
		if card then
			card:reset()
			if manual then return v end
			self:transferCard(card,to)
			return v
		end
	elseif type(id) == "table" then --id 为卡牌时 直接加入
		id:reset()
		self:transferCard(id,to)
		return id
	else --随机
		if #self.my.deck.cards == 0 then return end
		local card = table.random(self[whose].deck.cards)
		card:reset()
		self:transferCard(card,to)
	end
	
end

function game:makeCard(data)
	return Card(self,data,self.turn,self.my.library)
end


function game:refillCard(whose,id,level)
	whose = whose or "my"
	local to = self.my.bank
	if whose == "up" or whose == "down" then
		to = self[whose].bank
	end

	local data
	if id =="any" then
		local target
		repeat
			target = lib[love.math.random(#lib)]
		until not target.isHero
		data = target
	elseif type(id)=="string" then --名字
		data = self.cardData.short[id]
	elseif type(id) == "function" then --条件
		data= id(self[whose].library.cards)
	elseif type(id) == "table" then
		data = table.copy(id)
	else
		data = table.random(self[whose].library.cards)
	end

	if data then
		local tmp = table.copy(data)
		tmp.level = tmp.level or (level or 1)
		self:transferCard(self:makeCard(tmp),to)
	end
end

function game:transferCard(card ,to ,pos,passResort)
	local from = card.current
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

	if card.charging then return end --未充满能量

	self.cardPlayCount = self.cardPlayCount + 1
	self.lastPlayed = card

	for i,v in ipairs(self:ally()) do
		if v.ability.onCardPlay then
			v.ability.onCardPlay(v,game,card)
		end
	end

	for i,v in ipairs(self:foe()) do
		if v.ability.onFoePlay then
			v.ability.onFoePlay(v,game,card)
		end
	end


	if card.ability.onPlay then card.ability.onPlay(card,self) end

	if card.last or card.hp then
		self:transferCard(card,self.my.play)
	else

		self:killCard(card)
	end
	
	return true
end

function game:buyCard(card)

	if card.price and self.my.resource.gold + self.my.resource.magic < card.price then  return end

	self.lastBought = card
	
		
	for i,v in ipairs(self:ally()) do
		if v.ability.onCardBuy then
			v.ability.onCardBuy(v,game,card)
		end
	end

	
	for i,v in ipairs(self:foe()) do
		if v.ability.onFoeBuy then
			v.ability.onFoeBuy(v,game,card)
		end
	end

	if card.price then
		for i = 1 , card.price do
			if not self:lose(card,"my","gold") then 
				self:lose(card,"my","magic") 
			end
		end
	end

	if card.ability.onBuy then
		card.ability.onBuy(card,self) --不记得有无
	end

	if card.ability.onHold then
		self:transferCard(card,self.my.hand)
	else
		self:playCard(card)
	end

	return true

end

local res = {"gold","food","magic","skull"}

function game:gain(card,who,what)

	if what == "random" then 
		what = table.random(res) 
	end

	for i,v in ipairs(self:ally()) do
		if v.ability.onGain then
			what = v.ability.onGain(v,self,what)
		end
	end

	for i,v in ipairs(self:foe()) do
		if v.ability.onFoeGain then
			what = v.ability.onFoeGain(v,self,what)
		end
	end	

	local res = self[who].resource
	res[what] = res[what] + 1

	Effect(self,what,card,self.my.hero,false,1)
	
end

function game:lose(card,who,what)
	
	if what == "random" then 
		local candidate = {unpack(res)}
		repeat
			local item = table.pickRandom(candidate)
			if self[who].resource[item]>0 then
				what = item
				break
			end
		until #candidate == 0
		if what == "random" then return end
	end

	local res = self[who].resource
	if res[what] < 1 then return end
	res[what] = res[what] - 1
	
	local e = Effect(self,what,self[who].hero,{x=x,y=y},true,1,"outQuad")

	for i,card in ipairs(self:ally()) do
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
		end
	elseif self.my.resource.magic>0 then
		for i = 1, self.my.resource.magic do
			delay:new(i*0.1,nil,self.attackCard,self,target)
		end
	end
end




function game:feedCard(card,all,what)
	if all then
		if self.my.resource.food>0 then
			for i = 1, self.my.resource.food do
				delay:new(i*0.3,nil,self.feedCard,self,card)
			end
		elseif self.my.resource.magic>0 then
			for i = 1, self.my.resource.magic do
				delay:new(i*0.3,nil,self.feedCard,self,card)
			end
		end
		return
	end

	local food = (what or card.food) or "food"
	local amount = card.feedAmount or 1
	local resource = self.my.resource
	
	if resource[food]>= amount then
		--
	elseif  resource.magic >= amount then
		food = "magic"
	else
		return
	end

	if card.awaken == false then
		card.awaken = true
		card.ability.onAwake(card,self)
	end

	for i = 1, amount do
		self:lose(self.my.hero.card,"my",food)
		self:healCard(card)
	end

	if card.ability.onFeed then card.ability.onFeed(card,self,food) end


	for i,v in ipairs(self:ally()) do
		v.ability.onFeedAlly(v,self,card,food) 
	end

	return food
end

function game:weakestAlly(who,hurt,nosac)
	who = who or self.my
	local lowest 
	local value = 100
	for i,v in ipairs(who.play.cards) do
		if v.hp and (hurt and v.hp_max-v.hp>0 or true) and (nosac and v.noSacrificed or true) then
			if  v.hp<value then 
				lowest = {v}
				value = v.hp
			elseif v.hp==value then 
				table.insert(lowest,v)
			end
		end
	end
	if lowest then
		return table.random(lowest)
	end
end

function game:strongestAlly(who,hurt,nosac)
	who = who or self.my
	local strongest 
	local value = 0
	for i,v in ipairs(who.play.cards) do
		if v.hp and (hurt and v.hp_max-v.hp>0 or true) and (nosac and v.noSacrificed or true)then
			if  v.hp>value then 
				strongest = {v}
				value = v.hp
			elseif v.hp==value then 
				table.insert(strongest,v)
			end
		end
	end
	if strongest then
		return table.random(strongest)
	end
end


function game:randomAlly(who,hurt,nosac)
	who = who or self.my
	local candidate={}
	for i,v in ipairs(who.play.cards) do
		if v.hp and (hurt and v.hp_max-v.hp>0 or true) and (nosac and v.noSacrificed or true) then
			table.insert(candidate, v)
		end
	end
	if not candidate[1] then return end
	return table.random(candidate)
end

function game:attackOrder(who)
	local noHp = {}
	local ally = {}
	for i,v in ipairs(who.play.cards) do
		if v.hp then
			table.insert(ally, v)
		elseif v.charge then
			table.insert(noHp,v)
		end
	end

	if noHp[1] then return table.random(noHp) end

	if ally[1] then
		local strongest
		local strongest_hp = 0
		for i,v in ipairs(ally) do
			if v.hp>strongest_hp then
				strongest = {v}
				strongest_hp = v.hp
			elseif v.hp== strongest then
				table.insert(strongest,v)
			end
		end
		if not strongest then return end
		table.sort( strongest, function(a,b) return a.price<b.price end)
		return strongest[1]
	end
end


function game:healCard(card)

	if card =="weakest" then
		card = self:weakestAlly(true)
		if not card then card = self.my.hero.card end
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
		return true
	elseif card == "all" then
		for i,v in ipairs(self:ally()) do
			self:healCard(v)
		end
	elseif card then
		if not card.hp then return end
		card.hp = card.hp + 1
		if card.hp>card.hp_max then card.hp = card.hp_max end
		return true
	end

end


function game:attackCard(card)
	if self.my.resource.skull < 1 and self.my.resource.magic < 1 then return end

	if not self:lose(self.my.hero.card,"my","skull") then
		self:lose(self.my.hero.card,"my","skull")
	end
	
	self:attack(self.my.hero.card,card)
	return true
end

function game:damageCard(card)
	if card.intercept and card.charge and card.charge>0 then
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
	if card.isHero then
		if game.userside == card:getSide() then
			self:loser()
		else
			self:winner()
		end
		return
	end
-------------------------非在场牌-------------------
	if card.current == self.my.bank or card.current == self.your.bank then 
		self:transferCard(card , card.born.grave,_,passResort) 
	end

	if card.current == self.my.hand or card.current == self.your.hand then 
		self:transferCard(card , card.born.deck,_,passResort) 
	end


	if card.current == self.show then 
		self:transferCard(card , self.my.deck,_,passResort) 
	end
--------------------------------------------------
	
	if card:getSide() == self.my then  --自家牌kill
		for i,v in ipairs(self:ally()) do
			if v.ability.onAllyDie then
				v.ability.onAllyDie(v,self,card)
			end
		end
		for i,v in ipairs(self:foe()) do
			if v.ability.onFoeDie then
				v.ability.onFoeDie(v,self,card)
			end
		end
	else --对方牌kill
		for i,v in ipairs(self:ally()) do
			if v.ability.onFoeDie then
				v.ability.onFoeDie(v,self,card)
			end
		end
		for i,v in ipairs(self:foe()) do
			if v.ability.onAllyDie then
				v.ability.onAllyDie(v,self,card)
			end
		end
	end
	

	if card.ability.onKilled then 
		if card.ability.onKilled(card,self) then --directly kill
			self:transferCard(card , card.born.grave,_,passResort)
			return
		end
	end

	
	if card.back then
		self:transferCard(card , card.born.deck ,_,passResort)
	else --destroy
		if card.ability.onDestoryed then
			if card.ability.onDestoryed(card,self) then --self prevent
				self:transferCard(card , card.born.deck ,_,passResort)
				return
			end
		end

		for i,v in ipairs(self:ally()) do
			if v.ability.onDestroyCard then
				if v.ability.onDestroyCard(v,self,card) then --prevent
					self:transferCard(card, card.born.deck ,_,passResort)
					return
				end
			end
		end


		for i,v in ipairs(self:ally()) do --替身
			if v.instead then
				self:transferCard(card, card.born.deck ,_,passResort)
				self:killCard(v)
				return
			end
		end
		self:transferCard(card , card.born.grave,_,passResort)
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


function game:attack(from,to,ignore)
	if not from then from = self.my.hero.card end

	local my,your
	if card.current == self.my.play or card.current == self.my.hero then
		my = game.my
		your = game.your
	else
		my = game.your
		your = game.my
	end

	for i,card in ipairs(self:foe()) do
		if card.ability.onAnyAttack then
			card.ability.onAnyAttack(card,self,from)
		end
	end

	for i,card in ipairs(self:foe()) do
		if card.cancel and card.cancel>0 then
			card.cancel = card.cancel -1
			Effect(self,"attack",from,card,false,1,"inBack")
			Effect(self,"shield",card,card,false,1,"inBack")
			return
		end
	end

	local target
	local effect
	if #yourCards == 0 then 
		target = your.hero.card
	else
		local candidate={}
		for i,card in ipairs(self:foe()) do
			if card.intercept and not ignore then
				table.insert(candidate, card)
			end
		end

		

		if #candidate == 0 then --no intercept
			if type(to) == "table" then --a card
				target = to			
			elseif to == "weakest" then --
				target = self:weakestAlly(your) or your.hero.card
			elseif to == "hero" then
				target = your.hero.card
			else
				target = self:randomAlly(your)
			end
			effect = Effect(self,"attack",from,target,false,1,"inBack")	
			effect:addCallback(function() target:vibrate() end)
			from:standout()

		else -- for blockers
			
			target = self:attackOrder(your)
			

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

		

		if target.dodgeRate and love.math.random()<target.dodgeRate then
			effect:addCallback(function() target:turnaround() end)
			return
		end

		for i,v in ipairs(self:ally(my)) do
			if v.ability.onAllyAttack then
				local t = v.ability.onAllyAttack(v,self,target)
				if t then
					target = t
					break
				end
			end
		end


		for i,v in ipairs(self:ally(your)) do
			if v.ability.onFoeAttack then
				local t = v.ability.onFoeAttack(v,self,target)
				if t then
					target = t
					break
				end
			end
		end


		local result = self:damageCard(target)

		if result == "death" then

			effect:addCallback(function() target:vibrate(_,_,
				function()
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

function game:sacrificePre()
	for i,v in ipairs(self.my.play.cards) do
		if v.sacrifice then
			return v
		end
	end
end

function game:sacrificeCard(target)
	if #self.my.play.cards==0 and type(target)~="table" then return end
	
	local ally = self:ally()


	if target == "weakest" then
		target = self:sacrificePre() or self:weakestAlly(nil,nil,true)
	elseif target == "strongest" then
		target = self:sacrificePre() or self:weakestAlly(nil,nil,true)
	elseif target == "random" then
		target = self:sacrificePre() or self:randomAlly(nil,nil,true)
	elseif type(target)=="string" then
		for i,v in ipairs(ally) do
			if v.id == target then
				target = v
				break
			end
		end
	end


	for i,v in ipairs(ally) do
		if v.onSacrificeAlly then
			v.onSacrificeAlly(v,game,target)
		end
	end
		
	if target.ability.onSacrifice then target.ability.onSacrifice(target,self) end
	self:killCard(card)
end

function game:copyCard(card)
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
		return true
	end

	card.charge = card.charge+1
	card:updateCanvas()
	if card.chargeMax and card.charge >= card.chargeMax then
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
	local data = self.cardData.short[id]
	local c = self:makeCard(data)
	self:transferCard(c,game.my.play)
end

function game:AI(dt)

	if not self.aiToggle then return end

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

	delay:new(2,nil,function() 
		self:endturn()
		self.aiCD = 0.5
		self.aiEnd=false
	end)
	self.aiEnd=true
end

return game


