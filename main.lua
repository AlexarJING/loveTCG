require "include"

--[[
function love.load()
    gameState={}
    for _,name in ipairs(love.filesystem.getDirectoryItems("scenes")) do
        gameState[name:sub(1,-5)]=require("scenes."..name:sub(1,-5))
    end
    gamestate.registerEvents()
    gamestate.switch(gameState.start_scene)
end]]

function love.load()
	client:init()
end

function love.update(dt)
	client:update()
end