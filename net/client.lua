local client = {}

function client:init()

    -- Creating a client to connect to some ip address
    client = sock.newClient("192.168.10.33", 22122)

    -- Called when a connection is made to the server
    client:on("connect", function(data)
        print("Client connected to the server.")
    end)

    -- Called when the client disconnects from the server
    client:on("disconnect", function(data)
        print("Client disconnected from the server.")
    end)

    -- Custom callback, called whenever you send the event from the server
    client:on("hello", function(msg)
        print("The server replied: " .. msg)
    end)

    client:connect()

    --  You can send different types of data
    client:emit("greeting", "Hello, my name is Inigo Montoya.")
    client:emit("isShooting", true)
    client:emit("bulletsLeft", 1)
    client:emit("position", {
        x = 465.3,
        y = 50,
    })
end

function client:update()
    client:update()
end

return client