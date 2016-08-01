local data = {
	id = "coordinate",
	name = "Coordinate",
	faction = "metris",
	category = "conspiracy",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 5,
}

data.description = {
	"+2 charges to Metris cards",
 	"Reduce bomb timers by 1",
 	"Destroy after use ",
}

data.ability={
	onPlay = function(card,game)
		for i,v in ipairs(game.my.play.cards) do
			if v.faction == "metris" then
				if v.shield  then v.shield = v.shield + 2 end
				if v.charge  then 
					v.charge = v.charge + 2 
					if v.charge>=v.chargeMax then
						v.ability.onFullCharge(v,game)
					end 
				end
				if v.bomb then
					v.last = v.last - 1
					if v.last<1 then game:killCard(v) end 
				elseif type(v.last)== "number" then 
					v.last = v.last + 2
				end
			end
		end
	end,
}

return data