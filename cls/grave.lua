local grave = Class("grave")

function grave:init(game,root)
    self.cards={}
    self.name = "grave"
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = -700
        self.y = 0
        self.rx = 3.14
    else
        self.x = 700
        self.y = 0
        self.rx = 3.14
    end

end




function grave:rearrange()
    for i,card in ipairs(self.cards) do
        card:setAnimate(0.5,{x=self.x,y=self.y,rz=0,rx=3.14,scale = 0.5},"outQuad")
    end
end

function grave:update(dt)
    for i,card in ipairs(self.cards) do
        card:update(dt)
    end
end

function grave:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return grave