local story = {}
local current
local line
local parallel

function story.addData(d)
	line = {}
	parallel = {}
	current = 1
	for i,v in ipairs(d) do
		v.state = "begin"
		if v.parallel then
			table.insert(parallel, v)
		else
			table.insert(line, v)
		end
	end
	return story
end


function story.update(condition)
	local rt
	local cd = line[current]

	if cd then

		if cd.state == "begin" then
			if cd.begin then 
				rt = cd.begin()
				if rt then
					cd.state = "check"
				end
			else
				cd.state = "check"
			end
		elseif cd.state == "check" then
			cd.over = cd.over or function() return game:readyDiag() end
			rt =  cd.over()
			if rt then
				cd.state = "over"
				current = current + (type(rt) == "boolean" and 1 or rt)
			else
				if cd.update then cd.update() end
			end
		end

	end


	for i,cd in ipairs(parallel) do
		if cd.state == "begin" then
			if cd.begin then 
				rt = cd.begin(condition)
				if rt then
					cd.state = "check"
					return rt
				end
			else
				cd.state = "check"
			end
		elseif cd.state == "check" then
			cd.over = cd.over or function() return game:readyDiag() end
			rt =  cd.over(condition)
			
			if rt then
				if type(rt) == "number" then
					current = rt
				end
				cd.state = "over"
				return rt
			else
				if cd.update then 
					rt = cd.update()
					return rt
				end
			end
		end
	end

	return rt
end

return story