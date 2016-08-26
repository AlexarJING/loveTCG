local delay={}

delay.index=0
delay.stack={}  --k=id [1]=time, [2]=function [3]=arg
function delay:new(delayTime,since,func,...)
	--since=tostring(since)
	if type(delayTime) == "function" then
		self.index=self.index+1
		if since and self.stack[tostring(since)] and self.stack[tostring(since)][1] then
			delayTime=delayTime+self.stack[since][1]
		end
		self.stack[tostring(self.index)]={delayTime,func,{...}}
		return self.index
	else
		self.stack[tostring(delayTime)]={delayTime,func,{...}}
		return self.index
	end
	
	
end

function delay:update(dt)

	for k,v in pairs(self.stack) do
		if type(v[1]) == "function" then
			if v[1]() then
				v[2](unpack(v[3]))
				self.stack[k]=nil
			end
		else
			v[1]=v[1]-dt
			if v[1]<=0 then
				v[2](unpack(v[3]))
				self.stack[k]=nil
			end
		end
	end
end



return delay