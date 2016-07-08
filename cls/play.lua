local play = Class("play")
local moveSpeed = 0.5
function play:init(game,root)
    self.cards={}
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

end

function play:resort()
    if #self.cards<=self.maxCount then
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -#self.cards/2 +i -0.5) * card.w * card.scale
            else
                x= self.x +( -#self.cards/2 +i -0.5) * card.w * card.scale
            end
            --local y = self.y + 0.001*(x - self.x)^2
            --local rz = ( -#self.cards/2 +i -0.5)* 0.05
            card:animate(moveSpeed,{x=x,y=self.y},"outQuad")
            card:animate(moveSpeed,{rx=self.rx,rz=0})
        end
    else
        for i,card in ipairs(self.cards) do
            local x 
            if self.root == "up" then
                x= self.x -( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * card.scale
            else
                x= self.x +( -self.maxCount/2 + (i-0.5)*self.maxCount/ #self.cards ) * card.w * card.scale
            end
            --local y = self.y + math.abs(x - self.x)*0.1
            --local rz = ( -#self.cards/2 +i -0.5)* 0.05
            card:animate(moveSpeed,{x=x,y=self.y},"outQuad")
            card:animate(moveSpeed,{rx=self.rx,rz=0})
        end
    end
end


function play:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function play:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return play
