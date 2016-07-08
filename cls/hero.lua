local hero = Class("hero")
local Card = require "cls/card"
local img_food = love.graphics.newImage("res/others/food.png")
local img_gold = love.graphics.newImage("res/others/money.png")
local img_skull = love.graphics.newImage("res/others/skull.png")
local img_magic = love.graphics.newImage("res/others/magic.png")
local img_heart = love.graphics.newImage("res/others/hp.png")

function hero:init(game,root)
   
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = 350
        self.y = -280
      
    else
        self.x = -350
        self.y = 280      
    end
end


function hero:setHero(data)
	self.card = Card(self.game, data,self)
end


function hero:update(dt)
    if self.card then
    	self.card:update(dt)
    end
end

function hero:draw()
    if self.card then
    	self.card:draw()
    end
    love.graphics.setFont(self.game.font_content)
    love.graphics.setColor(255, 255, 255, 255)
    if self.root == "up" then
    	love.graphics.draw(img_gold, self.x-170,self.y-60)
    	love.graphics.draw(img_food, self.x-170,self.y-30)
    	love.graphics.draw(img_magic, self.x-170,self.y)
    	love.graphics.draw(img_skull, self.x-170,self.y+30)
        love.graphics.draw(img_heart, self.x-170,self.y+60)
    	love.graphics.print(" x "..self.parent.resource.gold , self.x-150,self.y-65)
		love.graphics.print(" x "..self.parent.resource.food , self.x-150,self.y-35)
		love.graphics.print(" x "..self.parent.resource.magic , self.x-150,self.y-5)
		love.graphics.print(" x "..self.parent.resource.skull , self.x-150,self.y+25)
        love.graphics.print(" x "..self.parent.resource.hp , self.x -150,self.y+55)
    else
    	love.graphics.draw(img_gold, self.x+70,self.y-60)
    	love.graphics.print(" x "..self.parent.resource.gold , self.x+90,self.y-65)
    	love.graphics.draw(img_food, self.x+70,self.y-30)
    	love.graphics.print(" x "..self.parent.resource.food , self.x+90,self.y-35)
    	love.graphics.draw(img_magic, self.x+70,self.y)
    	love.graphics.print(" x "..self.parent.resource.magic , self.x+90,self.y-5)
    	love.graphics.draw(img_skull, self.x+70,self.y+30)
    	love.graphics.print(" x "..self.parent.resource.skull , self.x+90,self.y+25)
        love.graphics.draw(img_heart, self.x+70,self.y+60)
        love.graphics.print(" x "..self.parent.resource.hp , self.x +90,self.y+55)
    end
end


return hero