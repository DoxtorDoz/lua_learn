local ball = require "/components/ball"
local platform = require "/components/platform"
local bricks = require "/components/bricks"
local walls = require "/components/walls"
local levels = require "/logic/levels"
local collisions = require "/logic/collisions"

local gamestate = "menu"



function love.load()
    bricks.construct_level(levels.sequence[1])
    walls.construct_walls()
end

function love.update(dt)
    if levels.game_finished then
        gamestate = "finished"
    end
    if gamestate == "menu" then
        --empty
    elseif gamestate == "pause" then
    elseif gamestate == "game" then
        ball.update(dt)
        platform.update(dt)
        bricks.update(dt)
        walls.update(dt)
        collisions.resolve_collisions(ball, platform, walls, bricks)
        levels.switch_next_level(bricks, ball)
    elseif gamestate == "finished" then

    end
    
end


function love.draw()
    if gamestate == "menu" then
        love.graphics.printf( "Arkanoide :D\n" ..
			"Arkanoide en Lua y Love2D\n"..
            "Pulsa [Enter] para comenzar",
			300, 250, 200, "center" )
    elseif gamestate == "pause" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
    love.graphics.print(
         "Juego pausado. Pulsa [Enter] para continuar, [ESC] para salir",
         50, 50)
    elseif gamestate == "game" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
    elseif gamestate == "finished" then
        love.graphics.printf( "Congratulations!\n" ..
        "You have finished the game!",
        300, 250, 200, "center" )
    end
    
    -- if levels.game_finished then
       
    -- end
end

function love.keyreleased(key, code)
    if gamestate == "menu" then
        if key == "return" then
            gamestate = "game"
        end
    elseif gamestate == "game" then
        if key == "escape" then
            gamestate = "pause"
        end
    elseif gamestate == "pause" then
        if key == "return" then
            gamestate = "game"
        end
        if key == "escape" then
            love.event.quit()
        end
    elseif gamestate == "finished" then
        if key == "return" then
            --reiniciar
            levels.current_level = 1
            gamestate = "game"
        elseif key == "escape" then
            love.event.quit()
        end
    end
   
end

function love.conf(t)
    t.console  = true
end

--love._openConsole()