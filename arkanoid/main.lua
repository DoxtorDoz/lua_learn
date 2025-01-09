local ball = require "ball"
local platform = require "platform"
local bricks = require "bricks"
local walls = require "walls"
local levels = require "levels"
local collisions = require "collisions"

rebote = love.audio.newSource("rebote.mp3", "static")
explosion = love.audio.newSource("brick_exp.mp3", "static")
pared = love.audio.newSource("rebote.mp3", "static")

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