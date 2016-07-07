local game = Class("game")
game.cardData = require "cls/cardDataLoader"
game.font_title = love.graphics.newFont(40)
game.font_content = love.graphics.newFont(20)


local sides = {"up","down"}


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
	end
	

	self.mousex = 0
	self.mousey = 0
	
	self:gameStart()
end

function game:update(dt)
	self.hoverCard = nil
	for i,side in ipairs(sides) do
		self[side].deck:update(dt)
		self[side].hand:update(dt)
		self[side].bank:update(dt)
		self[side].play:update(dt)
	end

	if self.hoverCard and self.click then
		self:clickCard()
	end
end

function game:gameStart()
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
		self:attackCard()
	elseif current == self.your.hero then
		self:attackHero()
	end
end

local hoverColor = {255,100,100,255}

function game:draw()
	self.bg:draw()
	for i,side in ipairs(sides) do
		self[side].deck:draw()
		self[side].hand:draw()
		self[side].bank:draw()
		self[side].play:draw()
	end
	if self.hoverCard then 
		self.hoverCard:draw(hoverColor)
	end
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
		if onPlay then onPlay(card,game) end
		self:transferCard(card,card.current,self.my.play)
	else

	end
end

return game


