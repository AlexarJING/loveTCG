local data = {
	img_name = "coordinate",
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
		for i,v in ipairs(game:ally(card,true)) do
			if v.faction == "metris" then
				if v.charge  then 
					v.charge = v.charge + 2 
					if v.chargeMax and v.charge>=v.chargeMax then
						v.ability.onFullCharge(v,game)
					end 
				end
				
				if v.timer then
					v.timer = v.timer - 1
					if v.timer<1 then v:cast("onTimeUp");game:killCard(v) end 
				end
								
				if type(v.last) == "number" then 
					v.last = v.last + 2
				end

				v:updateCanvas()
				v:turnaround()
			end
		end
	end,
}

return data