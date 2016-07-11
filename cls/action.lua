local action={}
action.stack={}

function action:add(target,act)
	if self.stack[target] then
		table.insert(self.stack[target], act)
	else
		self.stack[target] = {act}
	end
end


function action:update(dt)
	for k,ser in pairs(self.stack) do
		local act = ser[1]
		if act:update(dt) then --finish
			table.remove(ser, 1)
			if #ser ==0 then
				self.stack[k] = nil
			end
		end
	end
end