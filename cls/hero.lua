Class = require "lib.middleclass"
local hero = Class("hero")

function hero:init(root)
    self.cards={}
    self.go = msg.url(".")
    self.position = go.get_position()
    self.maxCount = 5
    self.root = root

    self.money = 0
    self.food = 0
    self.magic = 0
    self.skull = 0
end

function hero:gain(what,amount)


end

function hero:lost(what,amount)


end


return hero