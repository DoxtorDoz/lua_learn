local ball = require "/components/ball"
local platform = require "/components/platform"
local bricks = require "/components/bricks"
local walls = require "/components/walls"
local levels = require "/logic/levels"
local collisions = require "/logic/collisions"
local gamestate = require "logic/gamestate"



function love.load()
    bricks.construct_level(levels.sequence[1])
    walls.construct_walls()
end

function love.update(dt)
    ball.update(dt)
    platform.update(dt)
    bricks.update(dt)
    walls.update(dt)
    collisions.resolve_collisions(ball, platform, walls, bricks)
    levels.switch_next_level(bricks, ball)
end


function love.draw()
    ball.draw()
    platform.draw()
    bricks.draw()
    walls.draw()
    if levels.game_finished then
        love.graphics.printf( "Congratulations!\n" ..
			"You have finished the game!",
			300, 250, 200, "center" )
    end
end

function love.keyreleased(key, code)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.conf(t)
    t.console  = true
end

--love._openConsole()