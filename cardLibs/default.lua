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
			["serf"]={exp = 0 , level = 1},
			["vintner"]={exp = 0 , level = 1},
			["wealthypatron"]={exp = 0 , level = 1},
			["spiceroute"]={exp = 0 , level = 1},
			["collecttaxes"]={exp = 0 , level = 1},
		},
		["power"]={
			["embargo"]={exp = 0 , level = 1},
			["courtesan"]={exp = 0 , level = 1},		
			["courtlyintrigue"]={exp = 0 , level = 1},
			
		},
		["war"]={
			["militia"]={exp = 0 , level = 1},
		},
		["faith"]={
			["prayer"]={exp = 0 , level = 1},
		},
	}
}

data.coins = {}

data.heros = {	
	vespitole ={
		["captainviatrix"]= {exp = 0 , level = 1, lib = {
			[1]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="serf",
			},
			[2]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="spiceroute",
			},
			[3]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="collecttaxes",
			},
			[4]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="vintner",
			},
			[5]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="wealthypatron",
			},
			[6]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="embargo",
			},
			[7]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="courtesan",
			},
			[8]={
				["level"]=1,
				["exp"]=0,
				["category"]="power",
				["faction"]="vespitole",
				["id"]="courtlyintrigue",
			},
			[9]={
				["level"]=1,
				["exp"]=0,
				["category"]="war",
				["faction"]="vespitole",
				["id"]="militia",
			},
			[10]={
				["level"]=1,
				["exp"]=0,
				["category"]="faith",
				["faction"]="vespitole",
				["id"]="prayer",}
		},
	deck={}}
		},
	metris ={},
	daramek ={},
	endazu ={},
}

data.currentHero = {id="captainviatrix",faction = "vespitole"}
return data