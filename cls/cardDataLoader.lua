local data = {}
data.short ={}
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
for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	data[faction]={}
	for i,category in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		data[faction][category]={}
		for i,id in ipairs(lfs.getDirectoryItems("cards/"..faction.."/"..category)) do
			local id = string.sub(id,1,-5)
			data[faction][category][id] = require ("cards/"..faction.."/"..category.."/"..id)
			data.short[id] = data[faction][category][id]		
			table.insert(data.rarity[data.short[id].rare], data.short[id])
		end
	end	
end


return data
