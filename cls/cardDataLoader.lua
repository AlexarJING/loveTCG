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

--local record = {}

local lfs = love.filesystem
local index=0

for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	data[faction]={}
	--record[faction]={}
	for i,category in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		if lfs.isFile("cards/"..faction.."/"..category) then
			local id = string.sub(category,1,-5)
			index=index+1
			local d = require ("cards/"..faction.."/"..id)
			data[faction][id] = d
			data.index[index] = d
			data.short[id] = d
			d.id = id
			table.insert(data.rarity[d.rare], d)
			--record[faction][id] = {exp = 0, level = 3}

		else
			data[faction][category]={}
			--record[faction][category] = {}

			for i,id in ipairs(lfs.getDirectoryItems("cards/"..faction.."/"..category)) do
				local id = string.sub(id,1,-5)
				local d = require ("cards/"..faction.."/"..category.."/"..id)
				d.id = id
				data[faction][category][id] = d
				data.short[id] = d
				index=index+1
				data.index[index] = d
				table.insert(data.rarity[d.rare], d)
				--record[faction][category][id] = {exp =0,level = 3}
				--if d.isHero then print(id) end
			end	
		end
		
	end
end



return data
