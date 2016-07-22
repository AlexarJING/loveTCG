local library = Class("library")
local Card = require "cls/card"

local testlib = {
    [1]={
        ["level"]=1,
        ["exp"]=0,
        ["category"]="prosperity",
        ["faction"]="vespitole",
        ["id"]="loan",
    },
    [2]={
        ["level"]=1,
        ["exp"]=0,
        ["category"]="power",
        ["faction"]="vespitole",
        ["id"]="courtesan",
    },
    [3]={
        ["level"]=1,
        ["exp"]=0,
        ["category"]="war",
        ["faction"]="vespitole",
        ["id"]="soldier",
    },
}



function library:init(game,root)
    self.cards={}
    self.game = game
    self.root = root
    self.parent = game[root]
    if self.root == "up" then
        self.x = 650
        self.y = 360
    else
        self.x = -650
        self.y = -360
    end

end

function library:makeCard(data)
    return Card(self.game,data,self.root,self)
end


function library:setCards(data)
    local lib = data.lib
    --local lib = testlib
    for i,v in ipairs(lib) do
        local d= table.copy(self.game.cardData.short[v.id],_,true)
        d.level = v.level
        d.exp = v.exp
        table.insert(self.cards, d)
    end
end

 
function library:update(dt)
    for i,v in ipairs(self.cards) do
        v:update(dt)
    end
end

function library:draw()
    for i,v in ipairs(self.cards) do
        v:draw()
    end
end



return library