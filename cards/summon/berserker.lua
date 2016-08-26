local data = {
	img_name = "summonedberserker", --argorathflower
	name = "Berserker",
	faction = "summon",
	rare = 0,
	profile = {" The valley is ever fertile. The herds roam thick, on fours legs and on two. "},
	last = true,
	hp = 1,
	back = true,
}

data.description = {
 	"turn: attack",
 	"retaliate",
}

data.ability={
	onTurnStart = function (card,game) game:attack(card)end,
	onAttacked = function(card,game) game:attack(card) end,
}

return data