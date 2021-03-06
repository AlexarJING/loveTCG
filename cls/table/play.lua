local play = Class("play")
local moveSpeed = 0.5
function play:init(game,root)
    self.cards={}
    self.name = "play"
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = 0
        self.y = -100
        self.rx = 0
    else
        self.x = 0
        self.y = 100
        self.rx = 0 
    end

    self.maxCount= 8
    self.scale = 0.5
    self.w = 500
    self.h = 150 
end

function play:rearrange()

    if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -#self.cards/2 +i -0.5) * card.w * self.scale
            else
                x= self.x +( -#self.cards/2 +i -0.5) * card.w * self.scale
            end
            card:setAnimate(moveSpeed,{x=x,y=self.y,rz=0,rx=self.rx,scale=self.scale},"outQuad")
        end
    else
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * card.scale
            else
                x= self.x +( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * card.scale
            end
            card:setAnimate(moveSpeed,{x=x,y=self.y,rx=self.rx,rz=0,scale=self.scale},"outQuad")
        end
    end
end


function play:update(dt)
    for i,v in ipairs(self.cards) do
        if v.ability.always then v.ability.always(v,v.game) end
        v:update(dt)
    end
end

function play:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return play
