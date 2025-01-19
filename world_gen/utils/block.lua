

local Block = {}

Block.__index = Block

function Block.new(x,y,size,type)
    local self = setmetatable({}, Block)
    self.original_x = x
    self.original_y = y
    self.position_x = x
    self.position_y = y
    self.center_x = x + size / 2
    self.center_y = y + size / 2 
    self.size = size
    self.type = type
    return self
end

function Block:draw(w_angle, w_cx, w_cy)
    love.graphics.push()
    love.graphics.translate(w_cx, w_cy)
    love.graphics.rotate(w_angle)
    love.graphics.translate(-w_cx, -w_cy)
    

    love.graphics.setColor(255, 1, 1, self.type)
    love.graphics.rectangle("fill",
    self.position_x,
    self.position_y,
    self.size,
    self.size)

    love.graphics.pop()
end

function Block:update(x,y,world)
    local mouseX, mouseY = love.mouse.getPosition()
   --[[  if self.type == 1 then
        local isHover = mouseX > self.position_x and mouseX <= self.position_x + self.size and mouseY > self.position_y and mouseY <= self.position_y + self.size
    end ]]

    local angle = world.angle
    local cx, cy = world.center_x, world.center_y

    local dx = self.original_x - cx
    local dy = self.original_y - cy

    --local rotacion_x = dx * math.cos(angle) + dy * math.sin(angle) 
    --local rotacion_y = dx * math.sin(angle) + dy * math.ceil(angle)

    self.position_x = x * self.size + world.position_x
    self.position_y = y * self.size + world.position_y
    

    --self.position_x = x * self.size + world.position_x  + dx * math.cos(angle) - dy * math.sin(angle)
    --self.position_y = y * self.size + world.position_y  + dx * math.sin(angle) + dy * math.cos(angle)

    --self.position_x = cx + dx * math.cos(angle) - dy * math.sin(angle)
    --self.position_y = cy + dx * math.sin(angle) + dy * math.cos(angle)

end

return Block