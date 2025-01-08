
rebote = love.audio.newSource("rebote.mp3", "static")
explosion = love.audio.newSource("brick_exp.mp3", "static")

--[Variables y Objetos]

local ball = {}
ball.position_x = 450
ball.position_y = 450
ball.speed_x = 300
ball.speed_y = 300

ball.radius = 10


local platform = {}
platform.position_x = 500
platform.position_y = 500
platform.speed_x = 300

platform.width  = 140
platform.height = 20


local bricks = {}
bricks.position_x = 100
bricks.position_y = 100

bricks.width = 50
bricks.height = 30

bricks.rows = 8
bricks.columns = 11

bricks.top_left_position_x = 70
bricks.top_left_position_y = 50

bricks.horizontal_distance = 10
bricks.vertical_distance = 15

bricks.current_level_bricks = {}


local walls = {}
walls.wall_thickness = 1
walls.current_level_walls = {}

local levels ={}
levels.sequence = {}

levels.sequence[1] = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0 },
}



--[Funciones variables]

--> Ball

function ball.update(dt)
    ball.position_x = ball.position_x + ball.speed_x * dt
    ball.position_y = ball.position_y + ball.speed_y * dt
end


function ball.draw()
    local segment_in_circle = 16
    love.graphics.circle('line',
        ball.position_x,
        ball.position_y,
        ball.radius,
        segment_in_circle)
end

function ball.rebound(shift_ball_x, shift_ball_y)
    local min_shift = math.min(math.abs(shift_ball_x), math.abs(shift_ball_y))
    if math.abs(shift_ball_x) == min_shift then
        shift_ball_y = 0
    else
        shift_ball_x = 0
    end
    ball.position_x = ball.position_x + shift_ball_x
    ball.position_y = ball.position_y + shift_ball_y
    if shift_ball_x ~= 0 then
        ball.speed_x = -ball.speed_x
    end
    if shift_ball_y ~= 0 then
        ball.speed_y = -ball.speed_y
    end
end


--> Platform

function platform.update(dt)
    if love.keyboard.isDown("right") then
        platform.position_x = platform.position_x + (platform.speed_x * dt)
    end
    if love.keyboard.isDown("left") then
        platform.position_x = platform.position_x - (platform.speed_x * dt)
    end
end


function platform.draw()
    love.graphics.rectangle('line',
        platform.position_x,
        platform.position_y,
        platform.width,
        platform.height)
end

--> Bricks

function bricks.draw()
    for _, brick in pairs(bricks.current_level_bricks) do
        bricks.draw_brick(brick)
    end
end


function bricks.new_brick(position_x, position_y, width, height)
    return({position_x = position_x, 
    position_y = position_y, 
    width = width or bricks.width,
    height = height or bricks.height})
end


function bricks.draw_brick(single_brick)
    love.graphics.rectangle('line',
    single_brick.position_x,
    single_brick.position_y,
    single_brick.width,
    single_brick.height)
end


function bricks.update_brick(single_brick)
end


function bricks.add_to_current_level_bricks(brick)
    table.insert(bricks.current_level_bricks, brick)
end


function bricks.update(dt)
    for _, brick in pairs(bricks.current_level_bricks) do
        bricks.update_brick(brick)
    end
end


function bricks.construct_level()
    for row = 1, bricks.rows do
        for col = 1, bricks.columns do
            local new_brick_position_x = bricks.top_left_position_x + (col - 1) * (bricks.width + bricks.horizontal_distance)
            local new_brick_position_y = bricks.top_left_position_y + (row - 1) * (bricks.height + bricks.vertical_distance)
            
            local new_brick = bricks.new_brick(new_brick_position_x, new_brick_position_y)

            bricks.add_to_current_level_bricks(new_brick)
        end
    end
end

function bricks.remove_brick(brick)
    
    print("ladrillo eliminado")
    table.remove(bricks.current_level_bricks, brick)
    bricks.update()
end

--> Walls

function walls.update(dt)
    for _, wall in pairs(walls.current_level_walls) do
        walls.update_wall(wall)
    end
end

function walls.update_wall(single_wall)
end

function walls.draw_wall(single_wall)
    love.graphics.rectangle(
    'line', 
    single_wall.position_x, 
    single_wall.position_y, 
    single_wall.width, 
    single_wall.height)
end

function walls.draw()
    for _, wall in pairs(walls.current_level_walls) do
        walls.draw_wall(wall)
    end
end


function walls.new_wall(position_x, position_y, width, height)
    return({position_x = position_x, 
    position_y = position_y,
    width = width,
    height = height})
end


function walls.construct_walls()
    local left_wall = walls.new_wall(
        0,
        0,
        walls.wall_thickness,
        love.graphics.getHeight()
    )

    local right_wall = walls.new_wall(
        love.graphics.getWidth() - walls.wall_thickness,
        0,
        walls.wall_thickness,
        love.graphics.getHeight()
    )

    local top_wall = walls.new_wall(
        0,
        0,
        love.graphics.getWidth(), 
        walls.wall_thickness
    )

    local bottom_wall = walls.new_wall(
        0,
        love.graphics.getHeight() - walls.wall_thickness,
        love.graphics.getWidth() ,
        walls.wall_thickness
    )

    walls.current_level_walls["left"] = left_wall
    walls.current_level_walls["right"] = right_wall
    walls.current_level_walls["top"] = top_wall
    walls.current_level_walls["bottom"] = bottom_wall
end

--[COLISIONES]

local collisions = {}

function collisions.resolve_collisions()
    collisions.ball_platform_collision(ball, platform)
    collisions.ball_walls_collision(ball, walls)
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
        height = platform.height}

    local overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap(b,a)
    if overlap then
        ball.rebound(shift_ball_x, shift_ball_y)
        rebote:setPitch(1)
        rebote:play()
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
            bricks.remove_brick(i)
            explosion:play()
        end
    end
end

function collisions.ball_walls_collision(ball, brick)
    local a = {x = ball.position_x, 
    y = ball.position_y, 
    width = 2 * ball.radius, 
    height = 2 * ball.radius}

    for i, wall in pairs(walls.current_level_walls) do
        local b = {x = wall.position_x,
        y = wall.position_y,
        width = wall.width,
        height = wall.height}

        local overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap(b,a)

        if overlap then
            print("Colision entre bola y pared")
            ball.rebound(shift_ball_x, shift_ball_y)
            rebote:setPitch(0.5)
            rebote:play()
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

        if collisions.check_rectangles_overlap(a, b) then
            if platform.position_x > 10 then
                platform.position_x = platform.position_x - 20
            else
                platform.position_x = platform.position_x + 20
            end
            print("Colision entre bola y pared")
        end
    end
end




--[Funciones Love]

function love.load()
    bricks.construct_level()
    walls.construct_walls()
end

function love.update(dt)
    ball.update(dt)
    platform.update(dt)
    bricks.update(dt)
    walls.update(dt)
    collisions.resolve_collisions()
end


function love.draw()
    ball.draw()
    platform.draw()
    bricks.draw()
    walls.draw()
end

function love.keyreleased(key, code)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.conf(t)
    t.console  = true
end

love._openConsole()