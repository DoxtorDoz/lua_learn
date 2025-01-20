local Physics = require "/logic/physics"

local Player = {}

Player.__index = Player

function Player.new(name, x, y)
    local self = setmetatable({}, Player)
    self.name = name
    self.health = 100
    self.position_x = x or 100
    self.position_y = y or 100
    self.mass = 70
    self.speed_x = 0
    self.speed_y = 0
    self.width = 10
    self.height = 20
    self.angle = 0

    return self
end

function Player:draw()
    --love.graphics.setColor(60,186,108)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", self.position_x, self.position_y, self.width, self.height)

    --love.graphics.setColor(0,255,0)
    --love.graphics.rectangle("line", self.position_x, self.position_y, )
end

--TODO: CORREGIR LOS MOVIMIENTOS
function Player:update(dt)
    if love.keyboard.isDown("right") then
        self.speed_x = 300
        self.position_x = self.position_x + self.speed_x*dt
    end
    if love.keyboard.isDown("left") then
        self.speed_x = 300
        self.position_x = self.position_x - self.speed_x*dt
    end
    if love.keyboard.isDown("up") then
        self.speed_y = 1000
        self.position_y = self.position_y - self.speed_y*dt
        self.position_x = self.position_x - self.speed_x*dt
    end
    if love.keyboard.isDown("down") then
        self.speed_y = 300
        self.position_y = self.position_y + self.speed_y*dt
        self.position_x = self.position_x + self.speed_x*dt
    end

    local mouseX, mouseY = love.mouse.getPosition()
    if love.mouse.isDown("1") then
        self.position_x = mouseX
        self.position_y = mouseY
    end
    
end

function Player:jump()
    
end

function Player:walk(direction)
    
end

function Player:align_planet()
    
end

function Player:closer_blocks(planet)
    
end

return Player