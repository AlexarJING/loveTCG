local hand = Class("hand")
local moveSpeed = 0.5
function hand:init(game,root)
    self.cards={}
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = -100
        self.y = -280
    else
        self.x = 100
        self.y = 280
    end

    self.maxCount= 5
    self.scale = 0.5
    self.rx=0
end


function hand:rearrange()
    if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -#self.cards/2 +i -0.5) * card.w * self.scale
            else
                x= self.x +( -#self.cards/2 +i -0.5) * card.w * self.scale
            end
            card:setAnimate(moveSpeed,{x=x,y=self.y,rx=self.rx,rz=0,scale=self.scale},"outQuad")
        end
    else
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * self.scale
            else
                x= self.x +( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * self.scale
            end
            card:setAnimate(moveSpeed,{x=x,y=self.y,rx=self.rx,rz=0,scale=self.scale},"outQuad")
        end
    end
end


function hand:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function hand:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end


return hand