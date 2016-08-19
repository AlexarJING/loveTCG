sock = require "sock"
console = require "console"
db = {
	login = {},
	waiting = {},
	gaming = {}
}

local function findop(player)
	local match = {}
	for id, data in pairs(db.waiting) do
		local dr = math.abs(player.range - data.range)
		if dr<= 10 then
			table.insert(match, {id = id, range = dr})
		end
	end
	if #match == 0 then return end
	table.sort(match,function(a,b) return a.range<b.range end)
	return match[1]
end

local function startgame(player1,player2)
	local first = love.math.random()<0.5
	local tab = {player1,player2}
	local tabname = tostring(tab)
	local seed = love.timer.getTime()
	player1.client:emit("startgame",{
		name = player2.name,
		id = player2.id,
		hero = player2.hero,
		range = player2.range,
		deck = player2.deck,
		lib = player2.lib,
		first = first,
		seed = seed,
		tablenanme = tabname,
		tableplace = 1
		})
	player2.client:emit("startgame",{
		name = player1.name,
		id = player1.id,
		hero = player1.hero,
		range = player1.range,
		deck = player1.deck,
		lib = player1.lib,
		first = not first,
		seed = seed,
		tablenanme = tabname,
		tableplace = 2
		})
	player1.state = "gaming"
	player2.state = "gaming"
	db.gaming[tabname] = tab
end

function check(data)


end



function love.load()
    -- Creating a server on any IP, port 22122
   	console:init(0,0,800,600)
    server = sock.newServer("*", 22122)
    console:sys("server started")
    -- Called when someone connects to the server

    server:on("connect", function()
    end)

    server:on("login", function(data, client)
        console:sys("client: " .. tostring(client.connection) .. " has joint to the server")
        local userdata = {
        	name = data.name,
        	id = tostring(client.connection),
        	client = client,
        	state = "login"
    	}
    	db.login[client.connection] = userdata
        client:emit("login", userdata.id)
    end)




    server:on("search", function(data,client)
    	local user= data.id
    	local userdata = db.login[user]
    	if not userdata then client:emit("reconnect","can't find in login table") end
    	if userdata.state~="login" then client:emit("reconnect","player state conflit from that in server") end
    	userdata.deck = data.deck
    	userdata.lib = data.lib
    	userdata.hero = data.hero
    	userdata.range = data.range
    	local op = findop(userdata)
    	if op then
    		db.login[user] = nil
    		db.waiting[op.id] = nil
    		startgame(op,userdata)
    	else
    		userdata.state = "waiting"
    		db.waiting[user] = userdata
    		db.login[user] = nil
    		userdata.client:emit("reconnect","can't find in login table")
    	end
    end)

    server:on("stopwaiting",function(data,client)
    	local user = data.id
    	local userdata = db.waiting[user]
    	if not userdata then 
    		client:emit("reconnect","can't find in waiting table") 
    		return
    	end
    	if userdata.state~="waiting" then 
    		client:emit("reconnect","player state conflit from that in server")
    		return 
    	end
    	db.waiting[user] = nil
    	db.login[user]=userdata
    	userdata.state = "login"
    end)

    server:on("syncgame", function(data,client)
 
    	local player = db.gaming[data.tablename][data.tableplace]
    	local op = db.gaming[data.tablename][(data.tableplace == 1 and 2 or 1)]
    	if player.state~="gaming" or op.state~="gaming" then
    		player.client:emit("reconnect","player state conflit from that in server")
    		op.client:emit("reconnect","player state conflit from that in server")
    		return
    	end
    	op.client:emit("receivesync",{action = data.action,target = data.target})
   	end)


    server:on("win", function(data,client)
    	local player = db.gaming[data.tablename][data.tableplace]
    	local op = db.gaming[data.tablename][(data.tableplace == 1 and 2 or 1)]
    	db.gaming[data.tablename] = nil
    	db.login[player.id] = player
    	db.login[op.id] = op
    	player.state = "login"
    	op.state = "login"
    end)



    server:on("disconnect",function(data,client)
    	local id = tostring(client.connection)
    	console:sys("client: " .. id .. "lost connection")
    	db.waiting[id] = nil
    	db.login[id] = nil
    	for k,v in pairs(db.gaming) do
    		if v[1].id == id then
    			v[2].client:emit("win","foe lost connnect")
    			v[2].state = "login"
    			db.login[v[2].id] = v[2]
    			db.gaming[k]=nil
    			return
    		elseif v[2].id == id then
    			v[1].client:emit("win","foe lost connnect")
    			v[1].state = "login"
    			db.login[v[1].id] = v[1]
    			db.gaming[k]=nil
    			return
    		end
    	end
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