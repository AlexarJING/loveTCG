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

data.coins = {}

local lfs = love.filesystem
local index=0

for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	data[faction]={}
	
	for i,category in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		if lfs.isFile("cards/"..faction.."/"..category) then
			local id = string.sub(category,1,-5)
			index=index+1
			local d = require ("cards/"..faction.."/"..id)
			data.coins[id] = d
			data.index[index] = d
			data.short[id] = d
			d.id = id
			table.insert(data.rarity[d.rare], d)
		else
			data[faction][category]={}
			for i,id in ipairs(lfs.getDirectoryItems("cards/"..faction.."/"..category)) do
				local id = string.sub(id,1,-5)
				local d = require ("cards/"..faction.."/"..category.."/"..id)
				d.id = id
				data[faction][category][id] = d
				data.short[id] = d
				index=index+1
				data.index[index] = d
				
				table.insert(data.rarity[d.rare], d)
			end	
		end
		
	end
end


return data
