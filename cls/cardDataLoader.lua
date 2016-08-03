local data = {}
data.short ={}
data.index = {}
data.rarity = {
	[0]={},
	[1]={},
	[2]={},
	[3]={},
	[4]={},
	["H"]={},
	["E"]={}
}

local lfs = love.filesystem
local index=0

for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	data[faction]={}
	for i,category in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		data[faction][category]={}
		for i,id in ipairs(lfs.getDirectoryItems("cards/"..faction.."/"..category)) do
			local id = string.sub(id,1,-5)
			local d = require ("cards/"..faction.."/"..category.."/"..id)
			data[faction][category][id] = d
			data.short[id] = d
			index=index+1
			data.index[index] = d

			table.insert(data.rarity[data.short[id].rare], data.short[id])
		end
	end
end


return data
