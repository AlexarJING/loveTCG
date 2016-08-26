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
				["id"]="collecttaxes",
			},
			[3]={
				["level"]=1,
				["exp"]=0,
				["category"]="prosperity",
				["faction"]="vespitole",
				["id"]="wealthypatron",
			},

		},
	playerdata = {
		lib ={
			[1]={
				["level"]=3,
				["exp"]=0,
				["category"]="war",
				["faction"]="vespitole",
				["id"]="militia",
			},
			[2]={
				["level"]=3,
				["exp"]=0,
				["category"]="war",
				["faction"]="vespitole",
				["id"]="mercenary",
			},
			[3]={
				["level"]=3,
				["exp"]=0,
				["category"]="war",
				["faction"]="vespitole",
				["id"]="leadofcharge",
			},},
		faction = "vespitole",
		hero = "captainviatrix",
		deck ={}
	}

}



data.rule = {"chooseShow","playHand","feedAlly","aimFoe","buyBank","feedHero","attackHero"}


data.story = {
	{
		begin = function() 
			game.lockInput = true
			game.lockTime = true
			game:addDiag(0,5,"up","你好，准船长丽丝莱塔，在成为正式船长之前，你需要通过我的试炼")
			return true
		end,
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","相信你已经准备好了，不过照惯例，还是要介绍下我们的战斗规则。")
			return true
		end,
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","首先先来看看我们的牌桌，你跟你的对手是上下对称的。")
			return true
		end,
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","这里是你的牌库，你将从这里抽牌，上面的数字显示你牌库的数量。")		
			game:addDiag(5,3,"up","一般来讲，场上弃掉的牌也要回到这里。")
			game:addIndicator("down","deck")
			return true
		end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","这里是你的手牌，你可以点击这里的卡牌出牌。")
			game:addDiag(5,5,"up","还有一些特殊的卡牌是留在手中起作用的。")		
			game:addIndicator("down","hand")		
			return true
		end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","这里是你的牌堆，你可以用你的资源购买卡牌。")		
			game:addDiag(5,5,"up","牌堆每次补牌都要从卡组中随机复制一张加入牌堆。")	
			game:addIndicator("down","bank")		
			return true
		end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","这里是你的场牌区，持续性的卡牌将在这里。")
			game:addDiag(5,5,"up","你无法控制出牌的位置，结算时从左到右结算。")		
			game:addIndicator("down","play")		
			return true
		end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","这里是你的英雄，右侧是你的资源。生命为0游戏结束。")
			game:addDiag(5,5,"up","金币可以购买卡牌，食物可以补给随从")		
			game:addDiag(10,5,"up","骷髅用来攻击，魔法可以代替任意资源。")
			game:addIndicator("down","hero")		
			return true
		end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","中间旋转的硬币标志回合时间，一般30秒一个回合。")	
			game:addDiag(5,5,"up","你的回合中可以点击硬币或按空格键结束回合。")		
			game:addIndicator(0,0,500,20)		
			return true
		end,
		update = function () end,
		over = function() 
			if game:readyDiag() then
				game:clearIndicator()
				return true
			end	
		end
	},
	{
		begin = function() 
			game:addDiag(0,5,"up","在本方回合时，你可以出牌，买牌，攻击，补给，结束回合")
			game:addDiag(5,5,"up","在对方回合时，你无法行动，除了认输，认输任何时间都可以。")
			game:addDiag(10,5,"up","点击本方的随从即可补给,恢复生命")
			game:addDiag(15,5,"up","点击对方的随从即可攻击,卡牌生命为0时弃牌。")
			game:addDiag(20,5,"up","同样可以点击本方或对方的英雄")
			game:addDiag(25,5,"up","每回合结束时，会抓3张牌直到达到4张手牌，补充1此牌堆")
			game:addDiag(30,5,"up","每回合开始时，具有每回合关键字的随从行动")
			game:addDiag(35,3,"up","比如你牌堆中的佣兵就会攻击，随从攻击会随机挑选对手的随从。")
			game:addDiag(38,3,"up","如果没有随从，便会攻击对手英雄")

			return true
		end,
	},
	{
		begin = function() 
			game:addDiag(0,3,"up","现在你可以热热身，放手试着攻击我了。")
			return true
		end,
	},
	{
		begin = function() 
			game:addDiag(0,3,"down","好的，老师，请赐教！")
			game.lockInput = false
			game.lockTime = false
			return true
		end,
	},
	{
		parallel = true,
		begin = function(cond)
			if cond == "win" then
				game:addDiag(0,3,"up","很好,看来你可以进入下一阶段试炼了")			
				return "return"
			end
			
		end,
		update = function () 
			return "return"
		end,
		over = function() 
			if game:readyDiag() then
				game:winner()
				return true
			end	
		end
	},
	{
		parallel = true,
		begin = function(cond)
			if cond == "lose" then
				game:addDiag(0,5,"up","抱歉，看来你还需要进一步的训练。")			
				return "return"
			end	
	
		end,
		update = function () end,
		over = function() 
			if game:readyDiag() then	
				game:loser()
				return true
			else
				return "return"
			end	
		end
	},
	{
		parallel = true,
		begin = function(cond)
			if love.keyboard.isDown("s") then
				game:clearIndicator()
				game:clearDiag()
				return true
			end
		end,
		update = function () end,
		over = function() 			
			return 11
		end
	},
}

data.playerfirst = true
return data