local Utils = require "/Utils"
local Bloque = {}

Bloque.__index = Bloque

function Bloque.new(x,y,s, cx, cy)
    local self = setmetatable({}, Bloque)
    self.position_x = x--cx + 100
    self.position_y = y--cy - s/2
    self.size = s
    self.angle = math.rad(0)
    self.center_x = cx
    self.center_y = cy

    self.puntos = {}

    local p1 = {self.position_x, self.position_y}
    local p2 = {self.position_x + self.size, self.position_y}
    local p3 = {(self.position_x + self.size),self.position_y+self.size}
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


function Bloque:draw()
    love.graphics.setColor(255,255,255)
    self:draw_datos()
    love.graphics.line(self.puntos[1][1], self.puntos[1][2], 
        self.puntos[2][1], self.puntos[2][2],
        self.puntos[3][1], self.puntos[3][2],
        self.puntos[4][1], self.puntos[4][2],
        self.puntos[1][1],self.puntos[1][2])

    love.graphics.setColor(0,255,255)    
    love.graphics.print("A", self.puntos[1][1], self.puntos[1][2])
    love.graphics.print("B", self.puntos[2][1], self.puntos[2][2])
    love.graphics.print("C", self.puntos[3][1], self.puntos[3][2])
    love.graphics.print("D", self.puntos[4][1], self.puntos[4][2])
end

function Bloque:update(dt, centro)
    self:mov()
    self.center_x = centro.position_x
    self.center_y = centro.position_y
end

function Bloque:mov()
    if love.keyboard.isDown("s") then
        self.position_y = self.position_y + 1
    elseif love.keyboard.isDown("w") then
        self.position_y = self.position_y - 1
    elseif love.keyboard.isDown("a") then
        self.position_x = self.position_x - 1
    elseif love.keyboard.isDown("d") then
        self.position_x = self.position_x + 1
    elseif love.keyboard.isDown("space") then
        self.angle = 0
    end

    if love.keyboard.isDown("q") then
        self.angle = self.angle - 0.01
    elseif love.keyboard.isDown("e") then
        self.angle = self.angle + 0.01
    end

    local mouseX, mouseY = love.mouse.getPosition()
    if love.mouse.isDown("1") then
        self.position_x = mouseX + 50
        self.position_y = mouseY + 50
    end

    --self:update_coor()
    self:update_coors()
end

--[[ function Bloque:update_coor()

    self.puntos[1][1] = self.position_x
    self.puntos[1][2] = self.position_y

    self.puntos[2][1] = self.position_x + self.size
    self.puntos[2][2] = self.position_y

    self.puntos[3][1] = math.sqrt((self.position_x + self.size)^2)
    self.puntos[3][2] = math.sqrt((self.position_y + self.size)^2)

    self.puntos[4][1] = self.position_x
    self.puntos[4][2] = self.position_y + self.size 
end ]]

function Bloque:update_coors()

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

function Bloque:draw_datos()
    love.graphics.print("X: "..self.position_x..", Y: "..self.position_y.."\nAngle: "..math.rad(self.angle), love.graphics.getWidth() - 100, love.graphics.getHeight() - 30)
end

return Bloque