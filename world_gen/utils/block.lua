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

    self.puntos = {}

    local p1 = {self.position_x, self.position_y}
    local p2 = {self.position_x + self.size, self.position_y}
    local p3 = {self.position_x + self.size,self.position_y+self.size}
    local p4 = {self.position_x, self.position_y + self.size}

    --[[
            P1------P2
            |        |
            |        |
            P4------P3
    ]]

    table.insert(self.puntos, p1)
    table.insert(self.puntos, p2)
    table.insert(self.puntos, p3)
    table.insert(self.puntos, p4)

    return self
end

function Block:draw(w_angle, w_cx, w_cy)
    love.graphics.push()
    love.graphics.translate(w_cx, w_cy)
    love.graphics.rotate(w_angle)
    love.graphics.translate(-w_cx, -w_cy)
    

    love.graphics.setColor(255, 1, 1, self.type + 0.1)
   --[[  love.graphics.rectangle("fill",
    self.position_x,
    self.position_y,
    self.size,
    self.size) ]]

    love.graphics.setColor(255,255,255)
    --self:draw_datos()
    love.graphics.line(self.puntos[1][1], self.puntos[1][2], 
        self.puntos[2][1], self.puntos[2][2],
        self.puntos[3][1], self.puntos[3][2],
        self.puntos[4][1], self.puntos[4][2],
        self.puntos[1][1],self.puntos[1][2])


    love.graphics.pop()
end



function Block:update(world,dt)
    local mouseX, mouseY = love.mouse.getPosition()
    self.center_x = world.center_x
    self.center_y = world.center_y
    --[[  if self.type == 1 then
        local isHover = mouseX > self.position_x and mouseX <= self.position_x + self.size and mouseY > self.position_y and mouseY <= self.position_y + self.size
    end ]]

--[[     local angle = world.angle
    local cx, cy = world.center_x, world.center_y

    local dx = self.order_x - cx
    local dy = self.order_y - cy ]]

    --self.position_x = self.order_x  + world.position_x
    --self.position_y = self.order_y  + world.position_y  

    if love.keyboard.isDown("d") then
        self.angle = self.angle - 0.01 
    elseif love.keyboard.isDown("a") then
         self.angle = self.angle + 0.01 
    elseif love.keyboard.isDown("space") then
        self.angle = 0
    end

    self:update_coors()

 --[[    --local dx, dy = Utils.rotate_point(self.order_x + world.position_x, self.order_y + world.position_y, angle)
    local dx, dy = Utils.rotate_point((self.order_x - world.center_x), (self.order_y - world.center_y),  angle)

    --self.position_x =  dx
    --self.position_y =  dy

    self.position_x = self.order_x  + world.position_x
    self.position_y = self.order_y  + world.position_y ]]

end

function Block:update_coors()
    local npx, npy = self.position_x - self.center_x,
    self.position_y - self.center_y
    
    local px1, py1 = Utils.rotate_point(npx, npy, self.angle)

    self.puntos[1][1] = self.center_x + px1
    self.puntos[1][2] = self.center_y + py1

    local px2, py2 = Utils.rotate_point(npx + self.size, npy, self.angle)

    self.puntos[2][1] = self.center_x + px2
    self.puntos[2][2] = self.center_y + py2

    local px3, py3 = Utils.rotate_point(npx + self.size, npy + self.size, self.angle)

    self.puntos[3][1] = self.center_x + px3
    self.puntos[3][2] = self.center_y + py3

    local px4, py4 = Utils.rotate_point(npx, npy + self.size, self.angle)

    self.puntos[4][1] = self.center_x + px4
    self.puntos[4][2] = self.center_y + py4

end

return Block