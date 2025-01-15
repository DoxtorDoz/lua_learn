local World = {}

World.__index = World

function World.new(name, r, tile)
    local self = setmetatable({}, World)
    self.name = name
    self.radius = r
    self.tileset = tile or {}
    self.planet = {}

    local baseX = 10000 * love.math.random()
	local baseY = 10000 * love.math.random()
    local diameter = 2* self.radius
    for y=1, diameter do
        self.planet[y] = {}
        for x = 1, diameter do
            local deltaX = self.radius - x
            local deltaY = self.radius - y
            local distance = math.sqrt(deltaX^2 + deltaY^2)

            if distance - self.radius < 0.5 or self.radius/distance > 5 then
                self.planet[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
                if self.planet[y][x] > 0.5 then
                    self.planet[y][x] = 1
                else
                    self.planet[y][x] = 0
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
    local tileSize = 8
    for y = 1, diameter do
        for x  =1, diameter do
            --print(self.planet[y][x])
            if self.planet[y][x] ~= nil then
                love.graphics.setColor(1, 1, 1, self.planet[y][x])
                love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize-1, tileSize-1)
            end
        end
    end
end

return World