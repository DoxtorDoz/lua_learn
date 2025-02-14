local Centro = {}

Centro.__index = Centro

function Centro.new(x,y)
    local self = setmetatable({}, Centro)
    self.position_x = x
    self.position_y = y

    return self
end

function Centro:draw()
    love.graphics.push()
    love.graphics.setColor(255,0,0,0.3)
    love.graphics.circle("fill", self.position_x, self.position_y, 10)
    love.graphics.pop()
end

function Centro:update(dt)

    local mouseX, mouseY = love.mouse.getPosition()
    if love.mouse.isDown("1") then
        self.position_x = mouseX
        self.position_y = mouseY
    end
end

return Centro