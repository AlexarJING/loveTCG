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
			["banker"] = {exp = 0, level = 3},
			["collecttaxes"] = {exp = 0, level = 3},
			["fief"] = {exp = 0, level = 3},
			["harvest"] = {exp = 0, level = 3},
			["loan"] = {exp = 0, level = 3},
			["merchantsguild"] = {exp = 0, level = 3},
			["serf"] = {exp = 0, level = 3},
			["spiceroute"] = {exp = 0, level = 3},
			["tithe"] = {exp = 0, level = 3},
			["tradecompany"] = {exp = 0, level = 3},
			["vintner"] = {exp = 0, level = 3},
			["wealthypatron"] = {exp = 0, level = 3},
		},
		["power"]={
			["bounty"] = {exp = 0, level = 3},
			["bureaucrat"] = {exp = 0, level = 3},
			["corruption"] = {exp = 0, level = 3},
			["courtesan"] = {exp = 0, level = 3},
			["courtlyintrigue"] = {exp = 0, level = 3},
			["embargo"] = {exp = 0, level = 3},
			["masqueradeball"] = {exp = 0, level = 3},
			["spynetwork"] = {exp = 0, level = 3},
			["tribute"] = {exp = 0, level = 3},
			["usury"] = {exp = 0, level = 3},
			
		},
		["war"]={
			["ballista"] = {exp = 0, level = 3},
			["catapult"] = {exp = 0, level = 3},
			["knight"] = {exp = 0, level = 3},
			["leadofcharge"] = {exp = 0, level = 3},
			["marshall"] = {exp = 0, level = 3},
			["mercenary"] = {exp = 0, level = 3},
			["militia"] = {exp = 0, level = 3},
			["palisade"] = {exp = 0, level = 3},
			["rampart"] = {exp = 0, level = 3},
			["soldier"] = {exp = 0, level = 3},
			["warship"] = {exp = 0, level = 3},
		},
		["faith"]={
			["benediction"] = {exp = 0, level = 3},
			["bishop"] = {exp = 0, level = 3},
			["devotion"] = {exp = 0, level = 3},
			["holywrath"] = {exp = 0, level = 3},
			["inquisitor"] = {exp = 0, level = 3},
			["liturgy"] = {exp = 0, level = 3},
			["malediction"] = {exp = 0, level = 3},
			["miracle"] = {exp = 0, level = 3},
			["prayer"] = {exp = 0, level = 3},
			["sibyllinescrolls"] = {exp = 0, level = 3},
			["supplicant"] = {exp = 0, level = 3},
			["synod"] = {exp = 0, level = 3},
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
		}}
		},
	metris ={},
	daramek ={},
	endazu ={},
}

data.currentHero = {id="captainviatrix",faction = "vespitole"}
return data