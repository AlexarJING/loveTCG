local console= Class("console")
local w = 800
local h = 400

function console:init(parent,x,y,w,h)
	self.parent = parent
	self.content={}
	self.pos={x,y-h,w,h}--{l,t,w,h}
	self.font=love.graphics.newFont(15)
	self.caretPos={5,520,5,540}
	self.caretAlpha=0
	self.input=""
	self.countOneLine=math.floor(self.pos[3]/self.font:getWidth("0"))
	self.wordHeight=self.font:getHeight("1")
	self.language="en"
	self:calCaretPos()
	self.enable = false
	self.cmd ={}
end

local function lookForShort(word)
	for i=string.len(word),1,-1 do
		local sub=string.sub(word,1,i)
		if self.font:getWidth(sub)<self.pos[3]-10 and (string.sub(sub,i,i)==" " and self.language~="chinese") then
			return i
		end
	end
end

function console:send(diag)
	
	if self.cmd[diag.what] then self.cmd[diag.what]() end

	local word=diag.who..": "..diag.what
	local len=diag.who=="" and 0 or string.len(diag.who..": ")
	
	if self.font:getWidth(word)>self.pos[3]-10 then
		local pos=lookForShort(word)
		local newTab={
			who="",
			what=string.sub(diag.what,pos+1-len),
			time=0,
			color={unpack(diag.color)},
			step=diag.step
		}
		diag.what=string.sub(diag.what,1,pos-len)
		newTab.loc=-string.len(diag.what)
		
		table.insert(self.content, diag)
		if #self.content>10 then table.remove(self.content,1)end
		self:send(newTab)
	else
		table.insert(self.content, diag)
		if #self.content>10 then table.remove(self.content,1)end
	end
end


function console:say(who,what,step)
	local diag={
		who=who,
		what=what,
		time=0,
		color={0,255,0,255},
		step=step or 0.3
	}
	self:send(diag)
end

function console:shout(who,what,step)
	local diag={
		who=who,
		what=what,
		time=0,
		color={255,0,0,255},
		step=step or 0.3
	}
	self:send(diag)
end

function console:sys(what,step)
	local diag={
		who="System",
		what=what,
		time=0,
		color={255,255,0,255},
		step=step or 0.3
	}
	self:send(diag)
end

function console:update()


end

function console:draw()
	if self.enable == false then return end
	if self.isEdit then
		self.alpha=1
	else
		self.alpha=0.3
	end
	love.graphics.setColor(0, 255,0, 30*self.alpha)
	love.graphics.rectangle("fill", unpack(self.pos))
	love.graphics.setColor(0, 255,0, 50*self.alpha)
	love.graphics.line(self.pos[1],self.caretPos[2],self.pos[1]+self.pos[3],self.caretPos[2])

	for i,line in ipairs(self.content) do
		local what
		if line.step then
			line.loc=line.loc or 0
			line.loc=line.loc+line.step 
			if line.loc>string.len(line.what) then
				line.step=nil
			end
			if line.loc>0 then
				what=string.sub(line.what,1,math.floor(line.loc/2)*2)
			else
				what=""
			end
		else
			what=line.what
		end

		love.graphics.setFont(self.font)
		love.graphics.setColor(line.color[1],line.color[2],line.color[3],line.color[4])
		if line.who=="" then
			love.graphics.print(what, self.pos[1]+5, self.pos[2]+self.wordHeight*(i-1)+5)
		else
			love.graphics.print(line.who..": "..what, self.pos[1]+5, self.pos[2]+self.wordHeight*(i-1)+5)
		end
		if i==#self.content then 
			if what==self.lastWhat then
				self.bigAlpha=self.bigAlpha-3
				if self.bigAlpha<0 then self.bigAlpha=0 end
			else
				self.bigAlpha=line.color[4]
			end
			love.graphics.setColor(line.color[1],line.color[2],line.color[3],self.bigAlpha)

			local what_up
			--[[
			if line.who=="" then
				what_up=self.content[i-1].who..": "..string.sub(self.content[i-1].what,1,math.floor(self.content[i-1].loc)) 
				love.graphics.print(what_up, 0.3*w, 0.55*h,0,2,2)
				love.graphics.print(what, 0.3*w, 0.6*h,0,2,2)
			else
				love.graphics.print(line.who..": "..what, 0.3*w, 0.6*h,0,2,2)
			end]]
			if what=="" then what=what_up end
			self.lastWhat=what
		end
	end


	if self.isEdit then
		self.caretAlpha=self.caretAlpha+5
		if self.caretAlpha>255 then self.caretAlpha = 0 end
		love.graphics.setColor(255,255,255,self.caretAlpha)
		love.graphics.line(unpack(self.caretPos))
	end

	love.graphics.setColor(255, 100, 255,255*self.alpha)
	love.graphics.setFont(self.font)
	love.graphics.print(self.input, self.pos[1],self.caretPos[2])

end

function console:calCaretPos()
	local left=self.pos[1]+self.font:getWidth(self.input)
	self.caretPos[1]=left
	self.caretPos[3]=left
	self.caretPos[2]=self.pos[2]+self.pos[4]-20
	self.caretPos[4]=self.pos[2]+self.pos[4]-1
end

function console:textinput(t)
	if self.enable == false then return end
    if self.isEdit then
    	self.input=self.input..t
    	self:calCaretPos()
    end
end

function console:keypressed(key)
	if self.enable == false then return end
	if key=="return" then
		if self.isEdit then
			if self.input == "" then
				self.isEdit=false
				self.parent.keyLock = false
			else
				self:say("player",self.input,0.3)
				self.input=""
				self:calCaretPos()
			end
		else
			self.isEdit=true
			self.parent.keyLock=true
		end
	end

	if key=="backspace" and self.isEdit then
		self.input=string.sub(self.input,1,-2)
		self:calCaretPos()
	end
end

local function inRect(self)
	if self.parent.mousex<self.pos[1] then return end
	if self.parent.mousex>self.pos[1]+self.pos[3] then return end
	if self.parent.mousey<self.pos[2]+self.pos[4]*0.8 then return end
	if self.parent.mousey>self.pos[2]+self.pos[4] then return end
	
	return true
end

function console:mousepressed(key)
	if self.enable == false then return end
	if key==1 then
		if inRect(self) then
			if not self.isEdit then
				self.isEdit=true
				self.parent.keyLock=true
			end
		elseif self.isEdit then
			self.isEdit=false
			self.parent.keyLock=false
		end
	end
end

function console:toggle(toggle)
	self.enable = toggle
	if not self.enable then
		self.parent.keyLock=false
	end
end



return console

