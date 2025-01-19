

local Debug_HUD = {}

Debug_HUD.__index = Debug_HUD

function Debug_HUD.new()
    local self  = setmetatable({}, Debug_HUD)
    self.n_vecinos = 1
    self.colision = false
    self.player = nil
    return self
end


function Debug_HUD:draw()
    self:draw_colision()
    self:draw_neighbors()

 --[[    if self.player ~= nil then
        self:draw_speed()
    end ]]
end


function Debug_HUD:update(vecinos, colisiones, player)
    self:update_colision(colisiones)
    self:updateVecinos(vecinos)
    --self:update_player(player)
end


function Debug_HUD:updateVecinos(w)
    self.n_vecinos = w
end

function Debug_HUD:draw_neighbors()
    love.graphics.setColor(255,255,255)
    love.graphics.printf("Num vecinos: "..self.n_vecinos, 550, 30,200,"right")
end

--TODO:ARREGLAR ESTO!
function Debug_HUD:update_colision(w)
    self.colision = w
end

function  Debug_HUD:update_player(p)
    self.player = p
end

function Debug_HUD:draw_colision()
    if self.colision  then
        love.graphics.setColor(255,0,255)
        love.graphics.printf("Colision detectada", 550, 10, 200, "right")
    else
        love.graphics.setColor(0,0,255)
        love.graphics.printf("Sin colisiones", 550, 10, 200, "right")
    end
end

--[[ function Debug_HUD:draw_speed()
    local x,y = self.player.position_x, self.player.position_y
    
    local speed = 2*x*y/(x + y)
    
    love.graphics.setColor(0,255,255)
    love.graphics.printf("Velocidad: ".. speed, 550, 50, 200, "right")
end ]]

return Debug_HUD