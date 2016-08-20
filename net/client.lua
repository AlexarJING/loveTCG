local client = sock.newClient("192.168.10.33", 22122)

love.connection = 'offline'
client:on("connect", function()
   love.connection = "online"
end)


client:connect()
love.client =client

return function()
	love.update = function(...)
		love.client:update()
	end
end