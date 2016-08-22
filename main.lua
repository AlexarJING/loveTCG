
require "include"

--[[
function love.load()	`````
    gameState={}
    for _,name in ipairs(love.filesystem.getDirectoryItems("scenes")) do
        gameState[name:sub(1,-5)]=require("scenes."..name:sub(1,-5))
    end
    gamestate.registerEvents()
    gamestate.switch(gameState.start_scene)
end]]

Diag = require ("cls/dialogbub")
diag = Diag(200,400,"你好么你好么测试测试testtest")

function love.update(dt)
	diag:update(dt)
end

function love.draw()
	love.graphics.circle('fill', 200, 400, 10)
	diag:draw()
end