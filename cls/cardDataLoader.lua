local data = {}

local lfs = love.filesystem
for i,race in ipairs(lfs.getDirectoryItems("cards")) do
	for i,name in ipairs(lfs.getDirectoryItems("cards/"..race)) do
		local name = string.sub(name,1,-5)
		local path = "cards/"..race.."/"..name
		data[race] = data[race] or {}
		data[race][name] = require ("cards/"..race.."/"..name)
	end	
end

return data
