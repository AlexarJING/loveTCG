require "include"


function love.load()
    love.graphics.setBackgroundColor(100, 100, 100, 255)
    gameState={}
    for _,name in ipairs(love.filesystem.getDirectoryItems("scenes")) do
        gameState[name:sub(1,-5)]=require("scenes."..name:sub(1,-5))
    end
    gamestate.registerEvents()
    gamestate.switch(gameState.test)
end

