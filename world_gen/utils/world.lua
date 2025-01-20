local MouseHover = require "/utils/mouseHover"
local Block = require "/utils/block"
local World = {}
local angle  = 10

World.__index = World

function World.new(name, r, px, py, tyle)
    local self = setmetatable({}, World)
    self.name = name
    self.radius = r
    self.diameter = 2*self.radius
    self.tileSize = 16

    self.position_x = px + self.diameter * self.tileSize/2
    self.position_y = py + self.diameter * self.tileSize/2
    self.center_x = self.position_x 
    self.center_y = self.position_y
    
    self.tileSet = tyle or {}
    
    self.rotation = math.random(0,1)

    self.mass = 2 * math.pi * r * math.sqrt(r) * 1000
    
    self.size = self.diameter * self.tileSize
    self.angle = 0

    self.planet = self:generate_world()

    return self
end

function World:drawWorld()
    love.graphics.push()
    love.graphics.translate(self.center_x, self.center_y)
    love.graphics.rotate(self.angle)
    love.graphics.translate(-self.center_x, -self.center_y)

    for _,block in ipairs(self.planet) do
        block:draw(self.angle, self.center_x, self.center_y)
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
        self.position_x = mouseX - self.diameter * self.tileSize/2
        self.position_y = mouseY - self.diameter * self.tileSize/2
    --end
    end

    if love.keyboard.isDown("d") then
        self.angle = self.angle + dt * 0.001 
    elseif love.keyboard.isDown("a") then
         self.angle = self.angle - dt * 0.001 
    elseif love.keyboard.isDown("space") then
        self.angle = 0
    end

    for _, block in ipairs(self.planet) do
        if love.keyboard.isDown("d") then
            self.angle = self.angle + dt * 0.001 
        elseif love.keyboard.isDown("a") then
             self.angle = self.angle - dt * 0.001 
        end

        block:update(self,dt)
    end

    

    self.center_x = self.position_x + self.diameter * self.tileSize/2
    self.center_y = self.position_y + self.diameter * self.tileSize/2



--[[     if self.rotation == 1 then
        self.angle = self.angle + dt * 0.1 
    else
        self.angle = self.angle - dt * 0.1 
    end
    ]]


    

   --[[  for _,block in ipairs(self.planet) do
        block:update(self,dt)
    end ]]
end

--[[
    Generamos un mundo con Perlin en un array bidimensional, y comprobamos si entran detro de los limites
    del mundo en base a la formula sqrt((r-x)^2 + (r-y)^2). Esta generacion es temporal, y puede que mejore
    el metodo en un futuro, pero por ahora hace bien su trabajo.
]]


function World:generate_world()
    local gen = {}
    local baseX = 1000 * love.math.random()
	local baseY = 1000 * love.math.random()
    for y=1, self.diameter do
        gen[y] = {}
        for x = 1, self.diameter do
            local deltaX = self.radius - x
            local deltaY = self.radius - y
            local distance = math.sqrt(deltaX^2 + deltaY^2)

            if distance - self.radius < 0 or self.radius/distance > 5 then
                gen[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
                local position_x  = x * self.tileSize + self.position_x
                local position_y  = y * self.tileSize + self.position_y

                if gen[y][x] > 0.6 then
                    gen[y][x] = Block.new(position_x - self.center_x,position_y - self.center_y ,self.tileSize, 1)
                else
                    gen[y][x] = Block.new(position_x - self.center_x,position_y - self.center_y ,self.tileSize, 0)
                end
            else
                gen[y][x] = nil
            end
        end
    end
    --print(self.diameter)
    local curated = self:cure_world(gen)
    return curated
end


--[[
    Con este metodo buscamos reducir notablemente la forma en la que exploramos el conjunto de bloques generado,
    almacenando solo aquellos bloques que tienen contenido. Asi, en el resto de operaciones que involucren a los bloques, pasamos
    de O(N^2) a simplemente O(N)
]]
function World:cure_world(arr)
    local gen = {}
    --print(self.diameter)
    for y = 1, self.diameter do
        for x = 1, self.diameter do
            if arr[y] and arr[y][x] ~= nil then
                --print("bloque ["..x.."]["..y.."] entra")
                table.insert(gen, arr[x][y])
            end
        end
    end
    return gen
end

return World