local data = {
	id = "bloodlust",
	name = "Bloodlust",
	faction = "daramek",
	category = "rituals",
	rare = 1,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	basePrice = 6,
	back = true,
	last = true
}

data.description = {
	"Pick an enemy:",
	" Attack it until dead",
}

data.ability={
	onPlay = function (card,game)
		local options = {}
		for i,v in ipairs(game.your.play.cards) do
			if v.hp then table.insert(options,v.hp) end
		end
		if not options[1] then return end

		game:optionsCards(options)
		
		game.show.onChoose = function(target,game)
			card.attackTarget = target
			card.attackCD = 0.1
		end		
	end,
	always = function (card,game)
		if not card.attackTarget then return end
		card.attackCD = card.attackCD - 0.017
		if card.attackTarget.hp>0 and card.attackCD<0 then
			game:attack(card,card.attackTarget)
			card.attackCD = 0.1
		else
			card.attackTarget = nil
			game:killCard(card)
		end
	end
}

return data