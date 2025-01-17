local World = require "/utils/world"
local Player = require "/logic/player"
local Physics = require "/logic/physics"

local worlds = {}
local player = nil

function love.load()
    --love.window.setMode(1, 2)
    table.insert(worlds,World.new("Toad",24,100,100,{}))
    --table.insert(worlds,World.new("Road",20,300,300,{}))
    
    player = Player.new("Frogg", 400, 100)
end

function love.update(dt)
    

    for _,planet in ipairs(worlds) do
        planet:update(dt)
        --Physics.gravity_player_world(player, planet, dt)
        if player ~= nil  and planet ~=nil then
            player:update(dt, planet)
            Physics.update(dt,player,planet)
        end
        
    end
    
end

function love.draw()
    for _,p in ipairs(worlds) do
        p:drawWorld()
    end

    if player ~= nil then
        player:draw()
    end
    
end

function love.conf(t)
    t.console  = true
    --t.window.setTitle("Arkanoide")
end

love._openConsole()