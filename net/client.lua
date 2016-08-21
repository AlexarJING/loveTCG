local client = sock.newClient("192.168.1.5", 22122)

love.connection = 'offline'
client:on("connect", function()
   love.connection = "online"
end)

client:on("reconnect",function(msg)
	print(msg)
end)

client:connect()
love.client =client

return function()
	love.update = function(...)
		love.client:update()
	end
end