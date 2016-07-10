local grave = Class("grave")

function grave:init(game,root)
    self.cards={}
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

function grave:goback(card)
    card:animate(1,{x=self.x,y=self.y,rz=0,rx=3.14},"outQuad")
end

--[[
function grave:resort()
    for i,card in ipairs(self.cards) do
        card:animate(1,{x=self.x,y=self.y,rz=0,rx=3.14},"outQuad")
    end
end]]

function grave:update(dt)
    for i,card in ipairs(self.cards) do
        card:update(dt)
        if not card.tweens.x then
            table.remove(self.cards, i)
            return
        end
    end
end

function grave:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return grave