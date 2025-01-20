local Utils = require "/utils/Utils"
local Block = {}

Block.__index = Block

--[[ function Block.new(x,y,size,type)
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
end ]]

function Block.new(x,y,size,type)
    local self = setmetatable({}, Block)
    self.order_x = x
    self.order_y = y
    self.position_x = x
    self.position_y = y
    self.center_x = x
    self.center_y = y
    self.size = size
    self.type = type
    self.angle = 0
    return self
end

function Block:draw(w_angle, w_cx, w_cy)
    love.graphics.push()
    love.graphics.translate(w_cx, w_cy)
    love.graphics.rotate(w_angle)
    love.graphics.translate(-w_cx, -w_cy)
    

    love.graphics.setColor(255, 1, 1, self.type + 0.1)
    love.graphics.rectangle("fill",
    self.position_x,
    self.position_y,
    self.size,
    self.size)

    love.graphics.pop()
end



function Block:update(world,dt)
    local mouseX, mouseY = love.mouse.getPosition()
   --[[  if self.type == 1 then
        local isHover = mouseX > self.position_x and mouseX <= self.position_x + self.size and mouseY > self.position_y and mouseY <= self.position_y + self.size
    end ]]

    local angle = world.angle
    local cx, cy = world.center_x, world.center_y

    local dx = self.order_x - cx
    local dy = self.order_y - cy


    --self.position_x = self.order_x  + world.position_x
    --self.position_y = self.order_y  + world.position_y  

   

    if love.keyboard.isDown("d") then
        self.angle = self.angle + dt * 0.001 
    elseif love.keyboard.isDown("a") then
         self.angle = self.angle - dt * 0.001 
    elseif love.keyboard.isDown("space") then
        self.angle = 0
    end

    local dx, dy = Utils.rotate_point(self.order_x + world.position_x, self.order_y + world.position_y, angle)

--[[     self.position_x = self.order_x  + world.position_x - dx*0.1
    self.position_y = self.order_y  + world.position_y - dy*0.1 ]]

    self.position_x = self.position_x + dx
    self.position_y = self.position_y + dy


end

return Block