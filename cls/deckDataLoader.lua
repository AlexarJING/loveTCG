local data = {}


local lfs = love.filesystem

for i, deck in ipairs(lfs.getDirectoryItems("cardLibs/ai")) do
	local id = string.sub(deck,1,-5)
	table.insert(data, require("cardLibs/ai/"..id))
end



return data
