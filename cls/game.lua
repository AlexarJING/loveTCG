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

	self.comboCount = 0

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

	self.aiToggle = false

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
		self.my.hero.card.gold = 0
		self.my.hero.card.food = 0
		self.my.hero.card.magic = 999
		self.my.hero.card.skull = 0
	elseif key == "f2" then
		self.console:toggle(not self.console.enable)
	elseif key == "f3" then
		self.aiToggle = not self.aiToggle
	elseif key == "f5" then
		self:restart()
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

---------------------------------回合相关----------------------------------

function game:gameStart()
	self.console:sys("game start!")
	self.gameMode = "skirmish"
	self.turn = "down"
	self.my = self.down
	self.your = self.up
	self.userside = self.down

	
	self.turnButton:setTurn(self.turn)

	self.console:sys("setting table...")
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

function game:restart()

	self.gameMode = "skirmish"
	self.turn = "down"
	self.my = self.down
	self.your = self.up
	self.userside = self.down

	self.turnButton:setTurn(self.turn)

	
	local userdata = self.userdata
	local foedata = self.foedata

	self.up.deck:setCards(foedata)
	self.up.library:setCards(foedata)
	self.up.hero:setHero(foedata)

	local userHero = self.down.hero.card

	self.down.deck:setCards(userdata)
	self.down.library:setCards(userdata)
	self.down.hero:setHero({faction = userHero.faction,hero = userHero.id})


	self.up.play.cards = {}
	self.up.bank.cards = {}
	self.up.hand.cards = {}
	self.up.grave.cards = {}
	self.down.play.cards = {}
	self.down.bank.cards = {}
	self.down.hand.cards = {}
	self.down.grave.cards = {}

	for i = 1, 4 do
		self:refillCard("up")
		self:refillCard("down")
	end
	for i = 1, 3 do
		self:drawCard("up")
		self:drawCard("down")
	end
	
	self.up.resource=self.up.hero.card
	self.down.resource=self.down.hero.card

	self.turnCount = 0

	self:turnStart()
end


function game:endturn()
	self.console:sys(self.turn.."'s turn end!")
	self.turnButton:endturn()
end



function game:ally(card,allCards,noHero)
	local myAlly  = {}

	for i,v in ipairs(self.my.play.cards) do
		if v.hp or allCards then
			table.insert(myAlly, v)
		end
	end

	if not noHero then
		table.insert(myAlly,self.my.hero.card)
	end

	local yourAlly = {}
	for i,v in ipairs(self.your.play.cards) do
		if v.hp or allCards then
			table.insert(yourAlly, v)
		end
	end

	if not noHero then
		table.insert(yourAlly,self.your.hero.card)
	end

	if not card then return myAlly end

	if card:getSide() == self.my then
		return myAlly
	else
		return yourAlly
	end

end

function game:foe(card,allCards,noHero)
	
	local myAlly  = {}

	for i,v in ipairs(self.my.play.cards) do
		if v.hp or allCards then
			table.insert(myAlly, v)
		end
	end

	if not noHero then
		table.insert(myAlly,self.my.hero.card)
	end

	local yourAlly = {}
	for i,v in ipairs(self.your.play.cards) do
		if v.hp or allCards then
			table.insert(yourAlly, v)
		end
	end

	if not noHero then
		table.insert(yourAlly,self.your.hero.card)
	end

	if not card then return yourAlly end
	
	if card:getSide() == self.my then
		return yourAlly
	else
		return myAlly
	end

end

function game:turnStart()
	
	self.console:sys(self.turn.."'s turn end!")
	self.turnCount = self.turnCount + 1
	self.turnButton:setTurn(self.turn)
	local ally = self:ally(_,true)	

	for i,card in ipairs(ally) do
		card:cast("onTurnPre")
	end

	for i,card in ipairs(ally) do
		if not (card.undead and card.hp ==0) then ---undead
			card:cast("onTurnStart")
		end 
	end

	for i,card in ipairs(ally) do
		if card.timer then 
			card.timer = card.timer - 1
			card:updateCanvas()
			if card.timer<1 then
				card:cast("onTimeUp")
				self:killCard(card)
			end
		end 
	end

end

function game:turnEnd()

	local ally = self:ally(_,true)

	if #self.show.cards==1 then
		self:returnCard(self.show.cards[1])
	elseif #self.show.cards>1 then
		self:chooseCard(self.show.cards[1])
	end



	for i,card in ipairs(ally) do
		card:cast("onTurnEnd")
	end


	


	if not self.my.hero.card:cast("onDrawHand") then
		for i = 1, self.my.turnDrawCount do
			if #self.my.hand.cards>= self.my.handsize then break end
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


	
	self:turnStart()
end

--------------------------------------------------------------

function game:activateCard(card,target,force)
	if target == "all" then
		card:standout() 
		for i,v in ipairs(self:ally(card,true)) do
			if not v.activator or force then 
				self:activateCard(card,v)
			end
		end
	elseif type(target)== "string" then --id
		for i,v in ipairs(self:ally(card,true)) do
			if v.id == target then
				self:activateCard(card,v)
			end
		end
	else
		if not (target.undead and target.hp ==0) then ---undead
			target:cast("onTurnStart")
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
					self:chooseCard(cards[1])
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
	self.console:sys(self.turn.." chose "..card.id)
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
		card.born = self.my
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
	if id == "random" then
		local lib = self.cardData.index
		local target
		while true do
			target = lib[love.math.random(#lib)]
			if not target.isHero then
				local tCard = self:makeCard(target)
				self:transferCard(tCard,self.my.hand)
				return tCard
			end
		end
	elseif id == "ally" then
		local candidate = {}
		for i,v in ipairs(self[whose].deck.cards) do
			if v.hp then table.insert(candidate,v) end
		end

		if not candidate[1] then return end
		local target = table.random(candidate)
		self:transferCard(target,to)
		return target
	elseif type(id) == "string" then  ---当id为名字时
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
		if id.current == self.up.grave or id.current ==self.down.grave then return end --死了的不加入
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

function game:makeCard(data,whose)
	whose = whose or "my"
	local card = Card(self,data,whose,self[whose].library)
	return card
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
		data= id(self.cardData)
	elseif type(id) == "table" then
		data = table.copy(id) -- attentions!!! game:copyCard()
	else
		data = table.random(self[whose].library.cards)
	end

	if data then
		local tmp = table.copy(data)
		tmp.level = tmp.level or (level or 1)
		local target = self:makeCard(tmp,whose)
		self:transferCard(target,to)
	end
end

function game:transferCard(card ,to ,pos,passrearrange)
	local from = card.current
	if from.cards then table.removeItem(from.cards, card) end
	if from.rearrange and not passrearrange then from:rearrange() end
	if pos then
		table.insert(to.cards,pos, card )
	else
		table.insert(to.cards, card )
	end
	if to.rearrange and not passrearrange then to:rearrange() end
	card.current = to
end

function game:playCard(card)

	if card.charging then return end --未充满能量

	self.cardPlayCount = self.cardPlayCount + 1
	self.lastPlayed = card

	for i,v in ipairs(self:ally(card,true)) do
		v:cast("onCardPlay",card)
	end

	for i,v in ipairs(self:foe(card,true)) do
		v:cast("oFoePlay",card)
	end

	card:cast("onPlay")

	if card.last or card.hp or card.timer then
		self:transferCard(card,self.my.play)
	else
		self:killCard(card)
	end
	
	return true
end

function game:buyCard(card)

	if card.price and self.my.resource.gold + self.my.resource.magic < card.price then  return end

	self.lastBought = card
	card.born = self.my
		
	for i,v in ipairs(self:ally(card,true)) do
		v:cast("onCardBuy",card)
	end

	
	for i,v in ipairs(self:foe(card,true)) do
		v:cast("onFoeBuy",card)
	end

	if card.price then
		for i = 1 , card.price do
			if not self:lose(card,"my","gold") then 
				self:lose(card,"my","magic") 
			end
		end
	end

	card:cast("onBuy")
	

	if card.ability.onHold then
		self:transferCard(card,self.my.hand)
	else
		self:playCard(card)
	end

	return card

end

local res = {"gold","food","magic","skull"}

function game:gain(card,who,what)

	if what == "random" then 
		what = table.random(res) 
	end

	local whose = card:getSide(who)

	local res = whose.resource
	res[what] = res[what] + 1

	Effect(self,what,card,whose.hero,false,1)
	
	for i,v in ipairs(self:ally(card,true)) do
		v:cast("onGain",what)
	end

	for i,v in ipairs(self:foe(card,true)) do
		v:cast("onFoeGain",what)
	end	

	return what
end

function game:lose(card,who,what)
	
	local whose = card:getSide(who)

	if what == "random" then 
		local candidate = {unpack(res)}
		repeat
			local item = table.pickRandom(candidate)
			if whose.resource[item]>0 then
				what = item
				break
			end
		until #candidate == 0
		if what == "random" then return end
	end


	for i,card in ipairs(self:ally(card,true)) do
		card:cast("onLose",what)
	end

	for i,card in ipairs(self:foe(card,true)) do
		card:cast("onFoeLose",what)
	end

	local res = whose.resource

	if res[what] < 1 then return end
	res[what] = res[what] - 1
	
	local e = Effect(self,what,whose.hero,{x=x,y=y},true,1,"outQuad")

	return what
end

function game:steal(card,what)
	
	local res = self:lose(card,"your",what)

	if  res then
		self:gain(card,"my",res) 
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

	local food = (what or card.foodType) or "food"
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
		if not what  then  self:lose(self.my.hero.card,"my",food) end
		self:healCard(card)
	end

	if card.ability.onFeed then card.ability.onFeed(card,self,food) end


	for i,v in ipairs(self:ally(card,true)) do
		v:cast("onFeedAlly",card,food)
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

function game:attackOrder(cards)
	local noHp = {}
	local ally = {}
	for i,v in ipairs(cards) do
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


function game:healCard(card,full)

	if card =="weakest" then
		target = self:weakestAlly(card:getSide("my"),true)
		if not target then target = self.my.hero.card end
		return self:healCard(target,full)
	elseif card == "all" then
		for i,v in ipairs(self:ally()) do
			self:healCard(v,full)
		end
	elseif card then
		if not card.hp then return end
		card.hp = card.hp + (full and 100 or 1)
		if card.hp>(card.hp_max or 300) then card.hp = (card.hp_max  or 300 )end
		card:updateCanvas()
		return true
	end

end

function game:checkGameOver(card)
	if card.isHero then
		if self.userside == card:getSide() then
			self:loser()
		else
			self:winner()
		end
	end
end


function game:attackCard(card, all)

	if all then
		if self.my.resource.skull>0 then
			for i = 1, self.my.resource.skull do
				delay:new(i*0.1,nil,self.attackCard,self,target)
			end
		elseif self.my.resource.magic>0 then
			for i = 1, self.my.resource.magic do
				delay:new(i*0.1,nil,self.attackCard,self,target)
			end
		end
		return
	end


	if self:lose(self.my.hero.card,"my","skull") or self:lose(self.my.hero.card,"my","magic") then
		self:attack(self.my.hero.card,card)
		return true
	end
	
	
	
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
		if card.charge < 1 then 
			return "death" 
		end
	end

end

function game:killCard(card,passrearrange)
	
-------------------------非在场牌-------------------
	if card.current == self.my.bank or card.current == self.your.bank then 
		self:transferCard(card , card.born.grave,_,passrearrange) 
	end

	if card.current == self.my.hand or card.current == self.your.hand then 
		self:transferCard(card , card.born.deck,_,passrearrange) 
	end


	if card.current == self.show then 
		self:transferCard(card , self.my.deck,_,passrearrange) 
	end
--------------------------------------------------
	
	if card:getSide() == self.my then  --自家牌kill
		for i,v in ipairs(self:ally(card,true)) do
			if v:cast("onAllyDie",card) then return end
		end
		for i,v in ipairs(self:foe(card,true)) do
			v:cast("onFoeDie",card)
		end
	else --对方牌kill
		for i,v in ipairs(self:ally(card,true)) do
			v:cast("onFoeDie",card)
		end
		for i,v in ipairs(self:foe(card,true)) do
			if v:cast("onAllyDie",card) then return end
		end
	end
	

	if card:cast("onKilled") then 
		self:transferCard(card ,card.current, card.born.grave,_,passrearrange) --direct kill
		return
	end

	
	if card.back then
		self:transferCard(card , card.born.deck ,_,passrearrange)
	else --destroy
		self:destroyCard(card,passrearrange)
	end
	return true
end

function game:destroyCard(card,passrearrange)


	if card:cast("onDestroyed") then --self prevent
		self:transferCard(card , card.born.deck ,_,passrearrange)
		return
	end
	


	for i,v in ipairs(self:ally(card,true)) do
		if v:cast("onDestroyCard",card) then --other prevent
			v:standout()
			self:transferCard(card , card.born.deck ,_,passrearrange)
			return
		end
	end

	

	for i,v in ipairs(self:ally(card,true)) do
		if v.instead and card.born == card:getSide() then --other instead
			self:transferCard(card , card.born.deck ,_,passrearrange)
			self:killCard(v)
			return
		end
	end
	self:transferCard(card , card.born.grave,_,passrearrange)
	
end

function game:rearrangeAllCards()
	self.up.deck:rearrange()
	self.up.hand:rearrange()
	self.up.play:rearrange()
	self.up.grave:rearrange()
	self.down.deck:rearrange()
	self.down.hand:rearrange()
	self.down.play:rearrange()
	self.down.grave:rearrange()
end



function game:attack(from,to,ignore)
	if not from then from = self.my.hero.card end

	local my,your = from:getSide("my")
	local foe = self:foe(from,true)
	local ally = self:ally(from,true)

	if to == "infighting" then
		your,my = from:getSide("my")
		foe = self:ally(from,true)
		ally = self:foe(from,true)
	end

	for i,card in ipairs(foe) do
		if card.cancel and card.cancel>0 then
			card.cancel = card.cancel -1
			Effect(self,"attack",from,card,false,1,"inBack")
			Effect(self,"shield",card,card,false,1,"inBack")
			card:updateCanvas()
			return
		end
	end


	for i,card in ipairs(foe) do
		card:cast("onFoeAttack",from)
	end

	for i,card in ipairs(ally) do
		card:cast("onAllyAttack",from)
	end


	local target
	local effect
	if #your.play.cards == 0 then 
		target = your.hero.card
	else
		local candidate={}
		for i,card in ipairs(foe) do
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
			elseif to == "infighting" then
				target = self:randomAlly(my)
			else
				target = self:randomAlly(your)
			end
			effect = Effect(self,"attack",from,target,false,1,"inBack")	
			--effect:addCallback(function() target:vibrate() end)
		else -- for intercepters	
			target = self:attackOrder(candidate)
		end	
	end

	

	if type(to) == "table" and to~=target then
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

	else
		effect = Effect(self,"attack",from,target,false,0.5,"inBack")

	end




	for i,v in ipairs(ally) do
		local t = v:cast("onAllyAttack",target)
		if t then
			target = t
			break
		end
	end


	for i,v in ipairs(foe) do
		local t = v:cast("onFoeAttack",target)
		if t then
			target = t
			break
		end
	end

	from:standout()

	if target.dodgeRate and love.math.random()<target.dodgeRate then
		effect:addCallback(function() target:turnaround() end)
		return
	end

	from:cast("onAttack",target)

	local result = self:damageCard(target)



	if result == "death" then
		self:checkGameOver(target)
		effect:addCallback(function() target:vibrate(_,_,
			function()
				self:rearrangeAllCards()
			end) end)
		self:killCard(target,true)
	elseif result == "toHand" then
		self:transferCard(target ,target.current, target.my.hand ,_,true)
		effect:addCallback(function() target:vibrate(_,_,
			function()
				self:rearrangeAllCards()
			end)
		end)
	else
		target:cast("onAttacked",from)
		effect:addCallback(function() target:vibrate() end)
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
	elseif target == "all" then
		for i,v in ipairs(ally) do
			return self:sacrificeCard(v)
		end
	elseif type(target)=="string" then
		for i,v in ipairs(ally) do
			if v.id == target then
				target = v
				break
			end
		end
	end


	if not target then return end

	for i,v in ipairs(ally) do
		v:cast("onSacrificeAlly",target)
	end
		
	target:cast("onSacrifice")
	
	self:killCard(target)
	return target
end

function game:copyCard(card)
	return Card(self,card.data,card.born,card.current)
end

function game:allChargeTarget(my)
	local candidate = {}
	for i,v in ipairs(my.play.cards) do
		if cond and v.category == cond then
			table.insert(candidate)
		elseif not cond then
			table.insert(candidate)
		end
	end
	for i,v in ipairs(my.hand.cards) do
		if cond and v.category == cond then
			table.insert(candidate)
		elseif not cond then
			table.insert(candidate)
		end
	end
	return candidate
end

function game:chargeCard(card,cond)
	if not card.charge then return end
	
	if card == "random" then
		local candidate = self:allChargeTarget(card:getSide("my"))
		if candidate[1] then
			return self:chargeCard(table.random(candidate))
		else
			return false
		end
		
	elseif card =="all" then
		for i,v in ipairs(self:allChargeTarget(card:getSide("my"))) do
			self:chargeCard(v)
		end
		return true
	end

	card.charge = card.charge+1
	card:updateCanvas()
	if card.chargeMax and card.charge >= card.chargeMax then
		card.charge = card.chargeMax
		card:cast("onFullCharge")
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
			card:cast("onSleep")
		end
	end
end

function game:summon(id)
	local data = self.cardData.short[id]
	local c = self:makeCard(data)
	self:transferCard(c,self.my.play)
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


