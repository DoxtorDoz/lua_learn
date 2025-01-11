local walls = {}
walls.wall_thickness = 20
walls.current_level_walls = {}


function walls.update(dt)
    for _, wall in pairs(walls.current_level_walls) do
        walls.update_wall(wall)
    end
end

function walls.update_wall(single_wall)
end

function walls.draw_wall(single_wall)
    love.graphics.setColor(single_wall.color[1], single_wall.color[2], single_wall.color[3])
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


function walls.new_wall(position_x, position_y, width, height, color)
    return({position_x = position_x, 
    position_y = position_y,
    width = width,
    height = height,
    color = color})
end


function walls.construct_walls()
    local left_wall = walls.new_wall(
        0,
        0,
        1,
        love.graphics.getHeight(),
        {255, 255, 255}
    )

    local right_wall = walls.new_wall(
        love.graphics.getWidth()-200,
        0,
        1,
        love.graphics.getHeight(),
        {255, 255, 255}
    )

    local top_wall = walls.new_wall(
        0,
        0,
        love.graphics.getWidth(), 
        1,
        {255, 255, 255}
    )

    local bottom_wall = walls.new_wall(
        0,
        love.graphics.getHeight(),
        love.graphics.getWidth() ,
        1,
        {255, 0, 0}
    )

    walls.current_level_walls["left"] = left_wall
    walls.current_level_walls["right"] = right_wall
    walls.current_level_walls["top"] = top_wall
    walls.current_level_walls["bottom"] = bottom_wall
end

return walls