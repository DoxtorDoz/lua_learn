local World = require "/utils/world"

local worlds = {}

function love.load()
    local w = World.new("frog",30,{})
    
    table.insert(worlds,w)
end

function love.update(dt)
    
end

function love.draw()
    for _,p in ipairs(worlds) do
        p:drawWorld()
    end
    
end

function love.conf(t)
    t.console  = true
    --t.window.setTitle("Arkanoide")
end

love._openConsole()