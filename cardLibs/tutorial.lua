local data = {
	faction = "vespitole",
	hero = "sofocatro",
	lib = {
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
	deck = {},
}



data.rule = {"chooseShow","playHand","feedAlly","aimFoe","buyBank","feedHero","attackHero"}

data.dialog = {
	{sender="ai",content="你好，马上就要测试你战斗水平了，相信你可以准备好了，"},
	{sender="ai",content="那么，再此之前，让我们来简单的一下"}，
	{sender="ai",content="首先，这里是牌桌，上面有牌库区"},
	{sender="ai",content="手牌区"},
	{sender="ai",content="牌堆区"},
	{sender="ai",content="场牌区"},
	{sender="ai",content="几个位置，哦别忘了还有回合硬币"},
	{sender="ai",content="还有英雄卡牌区，旁边显示了你当前的资源情况"},
	{sender="ai",content="食物可以用来治疗，金币可以买东西，骷髅可以造成伤害，魔法可以充当前面的几种资源"},
	{sender="ai",content="点击手牌区来出牌,点击牌堆区来利用金币购买牌,买到的牌就直接出牌咯"},
	{sender="ai",content="每个卡牌有其各自的效果，点击右键来查看某个卡牌"},
	{sender="ai",content="好了，回合结束时，点击回合硬币即可"},
	{sender="ai",content="如果你的随从受伤了，或者想触发其补给效果，单击这个卡牌"},
	{sender="ai",content="如果你想消灭某个随从，点击这个随从，不过如果对手有护卫关键字的卡牌可能被挡住哦"},
	{sender="ai",content="你也可以直接攻击对方的英雄，对方英雄生命为0，你就赢了！剩下的看你的了"},
}




return data