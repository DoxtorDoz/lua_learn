local ball = require "/components/ball"
local platform = require "/components/platform"
local bricks = require "/components/bricks"
local walls = require "/components/walls"
local levels = require "/logic/levels"
local collisions = require "/logic/collisions"
local menu = require "/components/menu"
local score = require "/logic/score"
local lives = require "/logic/lives"
local gameover = require "/components/gameover"
local button = require "/utils/button"

--local colors = require "/components/colors"
local gamestate = "menu"
local t = true

function love.load()
    menu.load()
    levels.load()
    bricks.construct_level(levels.sequence[1])
    walls.construct_walls()
end

function love.update(dt)
    
    --button:update(dt)
    if levels.game_finished then
        gamestate = "finished"
    end
    if gamestate == "menu" then
        --empty
        menu.update()
        if menu.opciones == 1 then
            gamestate = "game"
        elseif menu.opciones == -1 then
            love.event.quit()
        end
    elseif gamestate == "pause" then
    elseif gamestate == "game" then
        if t then --Para obtener el nombre sin llamar al metodo 9 millones de veces.
                    --Seguramente se pueda hacer mejor de otra forma
            t = false
            score.load(menu.usuario:getTexto())
        --lives.update()
        end
        platform.update(dt)
        ball.update(dt, platform)
        bricks.update(dt)
        walls.update(dt)
        collisions.resolve_collisions(ball, platform, walls, bricks)
        levels.switch_next_level(bricks, ball)
        score.update()
    elseif gamestate == "finished" then
    end

    if lives.lives == 0 then
        gamestate ="game_over"
    end
    
end


function love.draw()

    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

    
    if gamestate == "menu" then
        menu.draw()
    elseif gamestate == "pause" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
        lives.draw()
    love.graphics.print(
        "Juego pausado. Pulsa [Enter] para continuar, [ESC] para salir",
        50, 50)
    elseif gamestate == "game" then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
        score.draw()
        lives.draw()
    elseif gamestate == "finished" then
        love.graphics.printf( "Congratulations!\n" ..
        "You have finished the game!",
        300, 250, 200, "center" )
    elseif gamestate == "game_over" then
        gameover.draw()
    end
end
--[[Control de eventos]]

function love.keyreleased(key, code)
    if gamestate == "menu" then
        --[[ if key == "return" then
            gamestate = "game"
        end ]]
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
    --t.window.setTitle("Arkanoide")
end

love._openConsole()