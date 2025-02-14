
local Bloque = require "/Bloque"
local Centro = require "/Centro"

local bloques = {}
local centro = nilq

function  love.load()
    centro = Centro.new(200,200)
    table.insert(bloques, Bloque.new(100,100,50, centro.position_x, centro.position_y))
    --table.insert(bloques, Bloque.new(160,160,50, centro.position_x, centro.position_y))
end

function love.update(dt)
    if centro then
        centro:update(dt)
    end
    for _, b in ipairs(bloques) do
        b:update(dt, centro)
        
    end
end

function love.draw()
    if centro then
        centro:draw()
    end
    
    for _, b in ipairs(bloques) do
        b:draw()
        love.graphics.setColor(255,255,255)
        love.graphics.line(centro.position_x, centro.position_y, b.puntos[1][1], b.puntos[1][2])

        love.graphics.line(centro.position_x, centro.position_y, b.puntos[4][1], b.puntos[4][2])

        --love.graphics.line(centro.position_x, centro.position_y, b.puntos[3][1] + math.sqrt((b.puntos[1][1] + b.size)^2 +(b.puntos[4][1] + b.size)^2)/2, b.puntos[3][2])
    end
end

function love.conf(t)
    t.console  = true
    --t.window.setTitle("Arkanoide")
end

love._openConsole()