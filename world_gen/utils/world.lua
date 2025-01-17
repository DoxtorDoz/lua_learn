local Block = require "/utils/block"
local World = {}

World.__index = World

function World.new(name, r, px, py, tyle)
    local self = setmetatable({}, World)
    self.name = name
    self.position_x = px
    self.position_y = py
    self.radius = r
    self.tileSet = tyle or {}
    self.tileSize = 8
    self.mass = 2 * math.pi * r * math.sqrt(r) * 1000
    --self.mass  = 1000000
    self.planet = {}

    local baseX = 1000 * love.math.random()
	local baseY = 1000 * love.math.random()
    local diameter = 2* self.radius
    for y=1, diameter do
        self.planet[y] = {}
        for x = 1, diameter do
            local deltaX = self.radius - x
            local deltaY = self.radius - y
            local distance = math.sqrt(deltaX^2 + deltaY^2)

            if distance - self.radius < 0.5 or self.radius/distance > 5 then
                self.planet[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
                --[[  if self.planet[y][x] > 0.6 then
                    self.planet[y][x] = 1
                elseif self.planet[y][x] >= 0.3 and self.planet[y][x] <= 0.6 then
                    self.planet[y][x] = 0.5
                else
                    self.planet[y][x] = 0
                end ]]
                local position_x  = x*self.tileSize + self.position_x
                local position_y  = y*self.tileSize + self.position_y
                if self.planet[y][x] > 0.6 then
                    --self.planet[y][x] = 1
                    self.planet[y][x] = Block.new(position_x,position_y,self.tileSize, 1)
                else
                    --self.planet[y][x] = 0
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
    --print("yes")
    local diameter = self.radius * 2
    for y = 1, diameter do
        for x  =1, diameter do
            --print(self.planet[y][x])
            if self.planet[y][x] ~= nil then

                --print("h")
                love.graphics.setColor(255, 255, 1, self.type)
                self.planet[y][x]:draw(x,y,self.position_x, self.position_y)

                --[[ if self.planet[y][x] == 1 then
                    love.graphics.setColor(60,186,108)
                else
                    love.graphics.setColor(29,58,109)
                end ]]
                --love.graphics.setColor(1, 1, 1, self.planet[y][x])
                --love.graphics.rectangle("fill", x*self.tileSize + self.position_x, y*self.tileSize + self.position_y, self.tileSize, self.tileSize)
            end
        end
    end

    local center_x = self.position_x + diameter* self.tileSize/2
    local center_y = self.position_y + diameter* self.tileSize/2

    love.graphics.setColor(1, 0, 255)
    love.graphics.rectangle("fill",center_x, center_y, 8, 8)

    --love.graphics.print("Masa: "..self.mass, 600, 700)
    --print("Masa: "..self.mass)
    local angle = math.deg(math.atan(center_x, center_y))
    --[[ if love.keyboard.isDown("right") or love.keyboard.isDown('d') then
        print("rotate der")
        love.graphics.rotate(angle)
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
        print("rotate izq")
        love.graphics.rotate(-angle)
    end ]]
end

function World:update(dt)

    local mouseX, mouseY = love.mouse.getPosition()

    if love.mouse.isDown("2") then
        self.position_x = mouseX
        self.position_y = mouseY
    end

    --actualizar cada boque del mundo
    for y = 1, self.radius*2 do
        for x = 1, self.radius*2 do
            if self.planet[y][x] ~= nil then
                self.planet[y][x]:update(x,y, self.position_x, self.position_y)
            end
        end
    end
end

return World