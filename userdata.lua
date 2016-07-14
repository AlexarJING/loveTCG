local data={}
data.cards = {
	["metris"]={
		["merder"]={
		},
		["underlings"]={
		},
		["espionage"]={
		},
		["conspiracy"]={
		},
	},
	["daramek"]={
		["idols"]={
		},
		["rituals"]={
		},
		["slaves"]={
		},
		["herd"]={
		},
	},
	["endazu"]={
		["inscriptions"]={
		},
		["anima"]={
		},
		["goetia"]={
		},
		["incantations"]={
		},
	},
	["vespitole"]={
		["prosperity"]={
			["serf"]={exp = 0 , level = 3},
			["merchantsguild"]={exp = 0 , level = 3},
			["loan"]={exp = 0 , level = 3},
			["vintner"]={exp = 0 , level = 3},
			["wealthyPatron"]={exp = 0 , level = 3},
			["spiceroute"]={exp = 0 , level = 3},
			["harvest"]={exp = 0 , level = 3},
			["tradecompany"]={exp = 0 , level = 3},
			["banker"]={exp = 0 , level = 3},
			["fief"]={exp = 0 , level = 3},
			["collecttaxes"]={exp = 0 , level = 3},
		},
		["power"]={
			["spynetwork"]={exp = 0 , level = 3},
			["embargo"]={exp = 0 , level = 3},
			["masqueradeball"]={exp = 0 , level = 3},
			["corruption"]={exp = 0 , level = 3},
			["courtesan"]={exp = 0 , level = 3},
			["bounty"]={exp = 0 , level = 3},
			["usury"]={exp = 0 , level = 3},
			["bureaucrat"]={exp = 0 , level = 3},
			["courtlyintrigue"]={exp = 0 , level = 3},
			["tribute"]={exp = 0 , level = 3},
		},
		["war"]={
			["palisade"]={exp = 0 , level = 3},
			["leadofcharge"]={exp = 0 , level = 3},
			["marshal"]={exp = 0 , level = 3},
			["ballista"]={exp = 0 , level = 3},
			["mercenary"]={exp = 0 , level = 3},
			["catapult"]={exp = 0 , level = 3},
			["rampart"]={exp = 0 , level = 3},
			["soldier"]={exp = 0 , level = 3},
			["warship"]={exp = 0 , level = 3},
			["knight"]={exp = 0 , level = 3},
			["militia"]={exp = 0 , level = 3},
		},
		["faith"]={
			["inquisitor"]={exp = 0 , level = 3},
			["devotion"]={exp = 0 , level = 3},
			["bishop"]={exp = 0 , level = 3},
			["benediction"]={exp = 0 , level = 3},
			["holywrath"]={exp = 0 , level = 3},
			["liturgy"]={exp = 0 , level = 3},
			["prayer"]={exp = 0 , level = 3},
			["malediction"]={exp = 0 , level = 3},
			["tithe"]={exp = 0 , level = 3},
			["synod"]={exp = 0 , level = 3},
			["supplicant"]={exp = 0 , level = 3},
			["sibylinescrolls"]={exp = 0 , level = 3},
		},
	}
}

data.coins = {}

data.heros = {	
	vespitole ={
		["regentmarsh"]={exp = 0 , level = 3 , lib = {}},
		["cardinalpocci"]={exp = 0 , level = 3, lib = {}},
		["sofocatro"]={exp = 0 , level = 3, lib = 
			{
				[1]={
				["level"]=3,
				["exp"]=0,
				["id"]="banker",
				["faction"]="vespitole",
				},
				[2]={
					["level"]=3,
					["exp"]=0,
					["id"]="fief",
					["faction"]="vespitole",
				},
				[3]={
					["level"]=2,
					["exp"]=0,
					["id"]="wealthyPatron",
					["faction"]="vespitole",
				},
				[4]={
					["level"]=3,
					["exp"]=0,
					["id"]="merchantsguild",
					["faction"]="vespitole",
				},
				[5]={
					["level"]=3,
					["exp"]=0,
					["id"]="loan",
					["faction"]="vespitole",
				},
				[6]={
					["level"]=3,
					["exp"]=0,
					["id"]="collecttaxes",
					["faction"]="vespitole",
				},
				[7]={
					["level"]=3,
					["exp"]=0,
					["id"]="spiceroute",
					["faction"]="vespitole",
				},
				[8]={
					["level"]=3,
					["exp"]=0,
					["id"]="harvest",
					["faction"]="vespitole",
				},
				[9]={
					["level"]=3,
					["exp"]=0,
					["id"]="wealthyPatron",
					["faction"]="vespitole",
				},
				[10]={
					["level"]=2,
					["exp"]=0,
					["id"]="fief",
					["faction"]="vespitole",
				},
			}
		},
		["ysadora"]={exp = 0 , level = 3, lib = {}},
		["madamaline"]={exp = 0 , level = 3, lib = {}},
		["captainviatrix"]={exp = 0 , level = 3, lib = {}}},
	metris ={},
	daramek ={},
	endazu ={},
}

data.currentHero = {id="sofocatro",faction = "vespitole"}
return data