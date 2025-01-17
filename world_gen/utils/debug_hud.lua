local Debug_HUD = {}

Debug_HUD.__index = Debug_HUD

function Debug_HUD.new()
    local self  = setmetatable({}, Debug_HUD)
    return self
end


function Debug_HUD.draw()
    
end


function Debug_HUD:update()
    
end

function Debug_HUD.draw_neighbors(n)
    --print("Hpla!")
    --love.graphics.printf(score.name, 550, 10, 200, "right")
    love.graphics.setColor(255,255,255)
    love.graphics.printf("Num vecinos: "..n, 400, 30,200,"right")
end

function Debug_HUD.collision_state(collision)

    if collision then
        love.graphics.printf("Colision detectada", 400, 10, 200, "right")
    else
        love.graphics.printf("Sin colisiones", 400, 10, 200, "right")
    end
    
end

return Debug_HUD