local bank = Class("bank")
local moveSpeed = 0.5

function bank:init(game,root)
    self.cards={}
    self.game = game
    self.name = "bank"
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
    self.scale = 0.5


    self.maxCount= 5
   
end


function bank:rearrange()
    if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local y 
            if self.root == "up" then
                y= self.cy + (i-1) * 100 - 250
            else
                y= self.cy - (i-1) * 100 + 250
            end
            card:setAnimate(moveSpeed,{x=self.cx , y = y,rz=self.rz,rx=0,scale=self.scale},"outQuad")
        end
    else
        local card = self.cards[1]
        card:setAnimate(moveSpeed,{x = self.outx, y = self.outy,rz = 0,rx=0,scale=self.scale})
        table.remove(self.cards, 1)
        self:rearrange()
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
