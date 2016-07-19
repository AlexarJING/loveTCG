local firework=Class("firework")
local spark  = love.graphics.newImage("res/others/spark.png")
local friction = 0.95
local gforce = 0.1

function firework:init(x,y,dx,dy,time,img,color)	
	self.color = color
	self.particles={}
	self.bomb = {
		x = x,
		y = y,
		dx = (0.5-love.math.random())*dx*2,
		dy = dy,
		time = time,
		img = img or spark,
		rate = 1,
		timer = 1/20,
	}
end

function firework:makeParticle(obj,life,makeP)
	local t  = life or love.math.random()*0.5+0.7
	local p = {
		x = obj.x,
		y = obj.y,
		dx = love.math.random(-5,5),
		dy = love.math.random(-5,5),
		img = obj.img,
		makeP =makeP or 0,
		maxlife = t,
		life = t,
	}
	table.insert(self.particles, p)
	return p
end


function firework:boom()
	for i = 1,50 do
		local p = self:makeParticle(self.bomb,1.5+ love.math.random()*0.5,0.3)
		p.dx=p.dx*3
		p.dy=p.dy*3
	end
	self.bomb = nil
end


function firework:update(dt)
	if self.bomb then
		local b = self.bomb
		b.dy = b.dy + gforce
		b.x = b.x + b.dx
		b.y = b.y + b.dy
		b.time = b.time - dt
		self:makeParticle(b)
		if b.time<0 then
			self:boom()
		end
	end

	for i = #self.particles , 1 ,-1 do
		local p = self.particles[i]
		p.dx = p.dx*friction
		p.dy = p.dy*friction + gforce
		p.x = p.x + p.dx
		p.y = p.y + p.dy
		p.makeP = p.makeP -dt
		if p.makeP>0 then
			self:makeParticle(p)
		end
		p.life = p.life - dt
		if p.life < 0 then
			table.remove(self.particles,i)
		end
	end
	if #self.particles == 0 then return true end
end


function firework:draw()

	local r,g,b = unpack(self.color)
	if self.bomb then
		local b = self.bomb
		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.draw(b.img, b.x, b.y)
	end

	
	for i,p in ipairs(self.particles) do
		love.graphics.setColor(r, g*(p.life/p.maxlife)^0.5, b*p.life/p.maxlife, 255*p.life/p.maxlife)
		love.graphics.draw(p.img,p.x,p.y)
	end


end


return firework