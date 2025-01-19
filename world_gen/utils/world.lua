local MouseHover = require "/utils/mouseHover"
local Block = require "/utils/block"
local World = {}
local angle  = 10

World.__index = World

function World.new(name, r, px, py, tyle)
    local self = setmetatable({}, World)
    self.name = name
    self.position_x = px
    self.position_y = py
    self.radius = r
    self.tileSet = tyle or {}
    self.tileSize = 8
    self.rotation = math.random(0,1)

    self.mass = 2 * math.pi * r * math.sqrt(r) * 1000
    self.diameter = 2*self.radius
    self.size = self.diameter * self.tileSize
    self.angle = 0
    
    self.center_x = self.position_x + self.diameter * self.tileSize/2
    self.center_y = self.position_y + self.diameter * self.tileSize/2

    self.planet = {}

    local baseX = 1000 * love.math.random()
	local baseY = 1000 * love.math.random()
    --local diameter = 2* self.radius
    for y=1, self.diameter do
        self.planet[y] = {}
        for x = 1, self.diameter do
            local deltaX = self.radius - x
            local deltaY = self.radius - y
            local distance = math.sqrt(deltaX^2 + deltaY^2)

            if distance - self.radius < 0 or self.radius/distance > 5 then
                self.planet[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
                local position_x  = x*self.tileSize + self.position_x
                local position_y  = y*self.tileSize + self.position_y
                if self.planet[y][x] > 0.6 then
                    self.planet[y][x] = Block.new(position_x,position_y,self.tileSize, 1)
                else
                    self.planet[y][x] = Block.new(position_x,position_y,self.tileSize, 0)
                end
            else
                self.planet[y][x] = nil
            end
        end
    end
    return self
end

function World:drawWorld()

    love.graphics.push()
    --love.graphics.translate(self.center_x, self.center_y)
    --love.graphics.rotate(self.angle)
    --love.graphics.translate(-self.center_x, -self.center_y)

    for y = 1, self.diameter do
        for x  =1, self.diameter do
            if self.planet[y][x] ~= nil then
                self.planet[y][x]:draw(self.angle, self.center_x, self.center_y)
            end
        end
    end

    love.graphics.pop()
 
    --Pintar el centro
    love.graphics.setColor(1, 0, 255)
    love.graphics.rectangle("fill",self.center_x, self.center_y, 8, 8)

    --Pintar el punto de inicio de creacion del planeta
    love.graphics.setColor(0, 255, 255)
    love.graphics.rectangle("fill",self.position_x, self.position_y, 8, 8)

    love.graphics.circle("line", self.center_x, self.center_y, self.radius*self.tileSize + 10)
end

function World:update(dt)

    local mouseX, mouseY = love.mouse.getPosition()


    if love.mouse.isDown("2") then
        
    --if MouseHover.check(self.position_x, self.position_y, self.size, self.size) then
        self.position_x = mouseX
        self.position_y = mouseY

        self.center_x = self.position_x + self.diameter * self.tileSize/2
        self.center_y = self.position_y + self.diameter * self.tileSize/2
    --end
end

--[[     if self.rotation == 1 then
        self.angle = self.angle + dt * 0.1 
    else
        self.angle = self.angle - dt * 0.1 
    end
    ]]

    --actualizar cada boque del mundo
    for y = 1, self.diameter do
        for x = 1, self.diameter do
            if self.planet[y][x] ~= nil then
                if love.keyboard.isDown("d") then
                   self.angle = self.angle + dt * 0.001 
                elseif love.keyboard.isDown("a") then
                    self.angle = self.angle - dt * 0.001 
                end
                self.planet[y][x]:update(x,y,self)
            end
            
        end
    end
end




return World