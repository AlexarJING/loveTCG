local data = {
	img_name = "liet",
	name = "Liet",
	faction= "daramek",
	profile = {"no money, you can do nothing!"},
	isHero = true,
	rare = 1,
	hp = 30
}

data.description = {
	"For each card you play", 
	"15%: +1 random resource ",
}

data.ability={
	onCardPlay = function (card,game)
		if love.math.random()<0.15 then game:gain(card,"my","random") end
	end,
}

return data