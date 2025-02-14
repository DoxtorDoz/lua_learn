local World = require "/utils/world"
local Player = require "/logic/player"
local Physics = require "/logic/physics"

local worlds = {}
local player = nil

function love.load()
    --love.window.setMode(1, 2)
    table.insert(worlds,World.new("Toad",8,100,100,{}))
    --table.insert(worlds,World.new("Road",12,300,300,{}))
    --table.insert(worlds,World.new("Fload",8,400,300,{}))
    
    player = Player.new("Frogg", 400, 100)

    Physics.load()
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

    
    if player ~= nil then
        player:draw()
    end


    for _,p in ipairs(worlds) do
        p:drawWorld()
        love.graphics.setColor(255,0,0)
        love.graphics.line(p.center_x, p.center_y, player.position_x, player.position_y)
        Physics.draw_blocks_collision(p.planet)
    end


    --Debug_HUD.draw()
    Physics.draw()
    
end

function love.conf(t)
    t.console  = true
    --t.window.setTitle("Arkanoide")
end

function  love.keyreleased(key, code)
    if key == "escape" then
        love.event.quit()
    end
    
end

love._openConsole()