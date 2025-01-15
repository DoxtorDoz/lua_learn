local walls = {}
walls.wall_thickness = 20
walls.current_level_walls = {}

local wave = {}

local function generateNoise(x, y, scale, offset)
    return love.math.noise((x + offset) * scale, y * scale)
end


function walls.update(dt)
    for _, wall in pairs(walls.current_level_walls) do
        walls.update_wall(wall)
    end

    --wave.offset = wave.offset +wave.speed * dt
    wave.offset = wave.offset + love.math.random(-10, wave.speed) * dt
end

function walls.update_wall(single_wall)

end

function walls.draw_wall(single_wall)
    love.graphics.setColor(single_wall.color[1], single_wall.color[2], single_wall.color[3])
    if not single_wall.death then
        love.graphics.rectangle(
            'line', 
            single_wall.position_x, 
            single_wall.position_y, 
            single_wall.width, 
            single_wall.height)
    else
        for x = 0, single_wall.width - 200 do
            local noiseValue = generateNoise(x, wave.offset, wave.scale, wave.offset)
            local ysin = single_wall.position_y - 6 + wave.amp * math.sin((x / wave.wvlen) * 2 * math.pi + wave.offset) + noiseValue * wave.noise_amp
            --local ycos = single_wall.position_y - 6 + wave.amp * math.cos((x / wave.wvlen) * 2 * math.pi + wave.offset) + noiseValue * wave.noise_amp
            --love.graphics.points(x, math.random(ysin, ycos))
            love.graphics.points(x, ysin)
        end
    end
    
end

function walls.draw()
    for _, wall in pairs(walls.current_level_walls) do
        walls.draw_wall(wall)
    end
end


function walls.new_wall(position_x, position_y, width, height, color, death)
    return({position_x = position_x, 
    position_y = position_y,
    width = width,
    height = height,
    color = color,
    death = death})
end


function walls.construct_walls()
    local left_wall = walls.new_wall(
        0,
        0,
        1,
        love.graphics.getHeight(),
        {255, 255, 255},
        false
    )

    local right_wall = walls.new_wall(
        love.graphics.getWidth()-200,
        0,
        1,
        love.graphics.getHeight(),
        {255, 255, 255},
        false
    )

    local top_wall = walls.new_wall(
        0,
        0,
        love.graphics.getWidth(), 
        1,
        {255, 255, 255}, false
    )

    local bottom_wall = walls.new_wall(
        0,
        love.graphics.getHeight(),
        love.graphics.getWidth() ,
        1,
        {255, 0, 0},
        true
    )

    walls.current_level_walls["left"] = left_wall
    walls.current_level_walls["right"] = right_wall
    walls.current_level_walls["top"] = top_wall
    walls.current_level_walls["bottom"] = bottom_wall

    wave.amp = 10
    wave.noise_amp = 15
    wave.wvlen = 100
    wave.speed = 20
    wave.offset = 10
    wave.scale = 0.5
end

return walls