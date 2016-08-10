local show = Class("show")
local moveSpeed = 0.5

function show:init(game)
    self.cards={}
    self.game = game

    self.x=0
    self.y=0
    self.scale = 1

end

function show:rearrange()

    for i,card in ipairs(self.cards) do
        local x = self.x +( -#self.cards/2 +i -0.5) * card.w * self.scale    
        card:setAnimate(moveSpeed,{x=x,y=self.y,rz=0,rx=0,scale=self.scale},"outQuad")
    end
end


function show:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function show:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return show