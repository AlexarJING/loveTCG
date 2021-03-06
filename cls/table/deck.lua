local deck = Class("deck")


function deck:init(game,root)
    self.cards={}
    self.name = "deck"
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = -450
        self.y = -250
        self.rx = 3.14
    else
        self.x = 450
        self.y = 250
        self.rx = 3.14
    end
    self.scale = 0.5
    self.w = 100
    self.h = 150
end


function deck:rearrange()
    
    for i,card in ipairs(self.cards) do
        card:setAnimate(0.5,{y=self.y},"inBack")
        card:setAnimate(0.5,{x=self.x,rz=0,rx=3.14,scale=self.scale},"outQuad")
    end
end


function deck:setCards(data)
    
    self.cards = {}

    for i = 1, 10 do
        local card
        if data.deck[i] then
            card = Card(self.game,cardData.short[data.deck[i]],self.root,self)
        else
            card = Card(self.game,cardData.short[data.faction.."coin"],self.root,self)
        end
        table.insert(self.cards, card)
    end

end

function deck:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

local font = love.graphics.newFont(50)

function deck:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf(tostring(#self.cards), self.x-100+2, self.y-30+2, 200, "center")
    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.printf(tostring(#self.cards), self.x-100, self.y-30, 200, "center")
end



return deck