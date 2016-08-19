local client = {}

function client:init()

    -- Creating a client to connect to some ip address
    client = sock.newClient("192.168.10.33", 22122)

    client:on("connect", function()
       client:emit("login",{name = "test"})
    end)

    client:connect()

   
    
end

function client:update()
    client:update()
end

return client