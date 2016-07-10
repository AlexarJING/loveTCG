local data = {}

local lfs = love.filesystem
for i,faction in ipairs(lfs.getDirectoryItems("cards")) do
	for i,name in ipairs(lfs.getDirectoryItems("cards/"..faction)) do
		local name = string.sub(name,1,-5)
		local path = "cards/"..faction.."/"..name
		data[faction] = data[faction] or {}
		data[faction][name] = require ("cards/"..faction.."/"..name)
	end	
end

return data
