local show = Class("show")

function show:init(game)
    self.cards={}
    self.game = game

    self.x=0
    self.y=0
    self.scale = 1
end

function show:resort()
    for i,card in ipairs(self.cards) do
        card:addAnimate(0.5,{x=self.x,y=self.y,scale = self.scale},"outQuad")
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