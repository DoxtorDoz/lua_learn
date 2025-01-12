
local sounds = require "sounds"
local score  = require "/logic/score"
local lives = require "/logic/lives"

local collisions = {}

function collisions.resolve_collisions(ball, platform, walls, bricks)
    collisions.ball_platform_collision(ball, platform)
    collisions.ball_walls_collision(ball, walls, platform)
    collisions.ball_bricks_collision(ball, bricks)
    collisions.platform_walls_collisions(platform, walls)
end

function collisions.check_rectangles_overlap(a,b)
    local overlap = false
    local shift_b_x, shift_b_y = 0, 0
    if not(a.x + a.width < b.x or b.x + b.width < a.x or 
    a.y + a.height< b.y or b.y + b.height < a.y) then
        overlap = true
        if(a.x + a.width / 2) < (b.x + b.width/2) then
            shift_b_x = (a.x + a.width) - b.x
        else
            shift_b_x = a.x - (b.x + b.width)
        end
        if(a.y + a.height / 2) < (b.y + b.height/2) then
            shift_b_y = (a.y + a.height) - b.y
        else
            shift_b_y = a.y - (b.y + b.height)
        end
    end
    return overlap, shift_b_x, shift_b_y
end


function collisions.ball_platform_collision(ball, platform)

    local a = {x = ball.position_x, 
        y = ball.position_y, 
        width = 2 * ball.radius, 
        height = 2 * ball.radius}

    local b = {x = platform.position_x, 
        y = platform.position_y, 
        width = platform.width, 
        --Para evitar que sobrepase el dibujado de la plataforma por abajo
        height = 2*platform.height}

    local overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap(b,a)
    if overlap then
        ball.rebound(shift_ball_x, shift_ball_y)
        if sounds.rebote:isPlaying() then
            sounds.rebote:stop()
        end
        sounds.rebote:setPitch(1)
        sounds.rebote:play()
        
    end

    if collisions.check_rectangles_overlap(a,b) then
        print("Colision entre bola y plataforma")
    end
end

function collisions.ball_bricks_collision(ball, bricks)
    local a = {x = ball.position_x, 
    y = ball.position_y, 
    width = 2 * ball.radius, 
    height = 2 * ball.radius}

    for i, brick in pairs(bricks.current_level_bricks) do
        local b = {x = brick.position_x,
        y = brick.position_y,
        width = brick.width,
        height = brick.height}

        local overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap(b,a)
        if overlap then
            print("Colision entre bola y ladrillo")
            ball.rebound(shift_ball_x, shift_ball_y)
            score.incrementScore(brick.type)
            if brick.type > 1 then
                bricks.degrade_brick(i, brick)
                if sounds.explosion:isPlaying() then
                    sounds.explosion:stop()
                end
                sounds.explosion:setPitch(5)
                sounds.explosion:play()
            else
                bricks.remove_brick(i)
                if sounds.explosion:isPlaying() then
                    sounds.explosion:stop()
                end
                sounds.explosion:setPitch(1)
                sounds.explosion:play()
            end
                

        end
    end
end

function collisions.ball_walls_collision(ball, walls, platform)
    local a = {x = ball.position_x, 
    y = ball.position_y, 
    width = 2 * ball.radius, 
    height = 2 * ball.radius}

    for i, wall in pairs(walls.current_level_walls) do
        local b = {x = wall.position_x,
        y = wall.position_y,
        --Para respetar la separacionde las paredes con la ventana, se añade el grosor/2
        width = wall.width + walls.wall_thickness / 2,
        height = wall.height + walls.wall_thickness / 2}

        local overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap(b,a)

        if overlap then
            if wall.death then
                lives.lose_life()
                ball.stick_to_platform(platform)
            else
                print("Colision entre bola y pared")
                ball.rebound(shift_ball_x, shift_ball_y)
                if sounds.rebote:isPlaying() then
                    sounds.rebote:stop()
                end
                sounds.rebote:setPitch(0.5)
                sounds.rebote:play()
            end
        end
    end
end



function collisions.platform_walls_collisions(platform, walls)
    local a = {x = platform.position_x, 
    y = platform.position_y, 
    width = platform.width, 
    height = platform.height}

    for i, wall in pairs(walls.current_level_walls) do
        local b = {x = wall.position_x,
        y = wall.position_y,
        width = wall.width,
        height = wall.height}
        if wall.death then
            
        else
            if collisions.check_rectangles_overlap(a, b) then
                if platform.position_x > 20 then
                    platform.position_x = platform.position_x - 20
                else
                    platform.position_x = platform.position_x + 20
                end
                if sounds.pared:isPlaying() then
                    sounds.pared:stop()
                end
                sounds.pared:setPitch(2)
                sounds.pared:play()
                print("Colision entre bola y pared")
            end
        end
        
    end
end

return collisions