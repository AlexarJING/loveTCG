local data = {}
data.short ={}

local lfs = love.filesystem
for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	data[faction]={}
	for i,category in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		data[faction][category]={}
		for i,id in ipairs(lfs.getDirectoryItems("cards/"..faction.."/"..category)) do
			local id = string.sub(id,1,-5)
			data[faction][category][id] = require ("cards/"..faction.."/"..category.."/"..id)
			data.short[id] = data[faction][category][id]
		end
	end	
end


return data
