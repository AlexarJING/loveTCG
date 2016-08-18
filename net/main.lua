sock = require "sock"
console = require "console"
function love.load()
    -- Creating a server on any IP, port 22122
   	console:init(0,0,800,600)
    server = sock.newServer("*", 22122)
    console:sys("server started")
    -- Called when someone connects to the server
    server:on("connect", function(data, client)

        console:sys("client: " .. tostring(client.connection) .. " has joint to the server")
        local msg = "Hello from the server!"
        client:emit("hello", msg)
    end)
end

function love.update(dt)
    server:update()
end

function love.draw()
	console:draw()
end

function love.mousepressed(x,y,key)
	console:mousepressed(key)
end

function love.textinput(t)
	console:textinput(t)
end

function love.keypressed(key)
	console:keypressed(key)
end