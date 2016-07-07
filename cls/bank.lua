local bank = Class("bank")

local Card = require "cls/card"

function bank:init(game,root)
    self.cards={}
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.cx = 550
        self.cy = 0
        self.rz = -0.5
        self.x = 650
        self.y = 360
        self.outx = 650
        self.outy = -360
    else
        self.cx = -550
        self.cy = 0
        self.rz = 0.5
        self.x = -650
        self.y = -360
        self.outx = -650
        self.outy = 360
    end



    self.maxCount= 5

end


function bank:resort()
    if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local y 
            if self.root == "up" then
                y= self.cy + (i-1) * 100 - 250
            else
                y= self.cy - (i-1) * 100 + 250
            end
            --local y = self.y + 0.001*(x - self.x)^2
            --local rz = ( -#self.cards/2 +i -0.5)* 0.05
            card:animate(1,{x=self.cx , y = y},"outQuad")
            card:animate(1,{rz=self.rz})
        end
    else
        local card = self.cards[1]
        card:animate(1,{x = self.outx, y = self.outy})
        table.remove(self.cards, 1)
        self:resort()
    end
end


function bank:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function bank:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end


return bank
