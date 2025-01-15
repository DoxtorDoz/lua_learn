local colors = require "/utils/colors"
local Explosion = require "/utils/explosion"

local explosions = {}

local bricks = {}
bricks.position_x = 100
bricks.position_y = 100

bricks.width = 35
bricks.height = 30

-- 0 for none, 1,2,3,... <-- durability of the brick

bricks.type = 0

bricks.rows = 8
bricks.columns = 11

bricks.top_left_position_x = 10
bricks.top_left_position_y = 50

bricks.horizontal_distance = 10
bricks.vertical_distance = 15

bricks.current_level_bricks = {}
bricks.no_more_bricks = false

function bricks.draw()
    for _, brick in pairs(bricks.current_level_bricks) do
        bricks.draw_brick(brick)
    end

    for _, exp in ipairs(explosions) do
        exp:draw()
    end
end

function bricks.new_brick(position_x, position_y, width, height, type)
    return({position_x = position_x, 
    position_y = position_y, 
    width = width or bricks.width,
    height = height or bricks.height,
    type = type})
end


function bricks.draw_brick(single_brick)
    --love.graphics.setColor(0, 0, 255)
    local color = colors.colors[single_brick.type]
    love.graphics.setColor(color[1], color[2], color[3])
    love.graphics.rectangle('line',
    single_brick.position_x,
    single_brick.position_y,
    single_brick.width, 
    single_brick.height)
end


function bricks.update_brick(single_brick)
    bricks.draw_brick(single_brick)
end


function bricks.add_to_current_level_bricks(brick)
    table.insert(bricks.current_level_bricks, brick)
end


function bricks.update(dt)
    --print(dt)
    if  #bricks.current_level_bricks == 0 then
        bricks.no_more_bricks = true
    else
        for _, brick in pairs(bricks.current_level_bricks) do
            bricks.update_brick(brick)
        end
    end

    for _, exp in ipairs(explosions) do
        
        exp:update(dt)
    end
end


function bricks.construct_level(levels_arr)
    --[[ Imprimir sin tabla (solo row y col)
    
    for row = 1, bricks.rows do
        for col = 1, bricks.columns do

            local new_brick_position_x = bricks.top_left_position_x + (col - 1) * (bricks.width + bricks.horizontal_distance)
            local new_brick_position_y = bricks.top_left_position_y + (row - 1) * (bricks.height + bricks.vertical_distance)
            
            local new_brick = bricks.new_brick(new_brick_position_x, new_brick_position_y)

            bricks.add_to_current_level_bricks(new_brick)
        end
    end]]

    for row_i, row in ipairs(levels_arr) do
        for col_j, type in ipairs(row) do
            if type ~= 0 then
                local new_brick_position_x = bricks.top_left_position_x + (col_j - 1) * (bricks.width + bricks.horizontal_distance)
                local new_brick_position_y = bricks.top_left_position_y + (row_i - 1) * (bricks.height + bricks.vertical_distance)
                
                local new_brick = bricks.new_brick(new_brick_position_x, new_brick_position_y, bricks.width,bricks.height,levels_arr[row_i][col_j])
                bricks.add_to_current_level_bricks(new_brick)
            end
        end
    end
end

function bricks.degrade_brick(pos, brick)
    print("ladrillo degradado")
    bricks.explosion(bricks.current_level_bricks[pos], 10)
    bricks.current_level_bricks[pos].type = brick.type - 1
    --bricks.update()
end

function bricks.remove_brick(brick)
    
    print("ladrillo eliminado")
    bricks.explosion(bricks.current_level_bricks[brick], 30)
    table.remove(bricks.current_level_bricks, brick)
    --bricks.update()
end

function bricks.explosion(b, n)
    print(b.height)
    table.insert(explosions, Explosion.new(b.position_x + b.width/2, b.position_y + b.height/2, colors.colors[b.type], n))
    print("exp anadida")
    --table.insert(explosions, Explosion.new(300, 300, colors.colors[4], n))
end

return bricks