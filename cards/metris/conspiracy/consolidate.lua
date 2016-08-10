local data = {
	img_name = "consolidate",
	name = "Consolidate",
	faction = "metris",
	category = "conspiracy",
	rare = 3 ,
	profile = {"The divine word can encourage even the mouse to rise against the wolf. –Abbot Capraretto"},
	basePrice = 3,
	last = 5

}

data.description = {
	"On turn: Heal hero/allies",
 	"50%: save destroyed ally",
	"Destroy after use ",
}

data.ability={
	onTurnStart = function(card,game)		
		game:healCard("all")
	end,
	onDestroyCard = function (card,game,target)
		if  target.hp and target.born == card:getSide()  and love.math.random()<0.5 then
			return true
		end
	end
}

return data