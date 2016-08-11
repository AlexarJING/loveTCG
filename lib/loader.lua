local loader = {}

function loader:new(parent,filename)
	local file  = love.filesystem.newFile(filename, "r")
	local contents = file:read()
	file:close()
	local lineStart = [[local p , c = ...
]]
	local lineEnd = [[	
c:push("done")]]
	local codestring = lineStart .. contents .. lineEnd
	self.thread = love.thread.newThread(codestring)
	self.channel = love.thread.getChannel(name)
	self.startTime = love.timer.getTime()
	self.thread:start(parent , self.channel)

end

function loader:update(dt)
	local test = self.channel:pop()
	self.timer = love.timer.getTime() - self.startTime
	if test == "done" then
		self.finishTime = love.timer.getTime() - self.startTime
		self.finish = true
	end
end



return loader