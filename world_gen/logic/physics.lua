local Debug_HUD = require "/utils/Debug_HUD"

local Physics = {}

local debug 
local vecinos = 0
local colisiones = false

local G = 6.67 * 10^(-1)

function Physics.load()
    debug = Debug_HUD.new()
end

function Physics.draw()
    debug:draw()
end

    --[[2 conceptos:
            1. Gravedad respecto al planeta
            2. Colisiones con los bloques que forman el planeta
    ]]


function Physics.update(dt,player,world)
    Physics.gravity_player_world(player,world,dt)

    local a = {
        x = player.position_x,
        y = player.position_y,
        width = player.width,
        height = player.height
    }
    local near_blocks = Physics.near_blocks_to_player(player, world)
    vecinos =  tonumber(#near_blocks) or 0
    if #near_blocks >= 1 then
        for i = 1, #near_blocks do

            local b = {
                x = world.center_x,
                y = world.center_y,
                width = near_blocks[i].size,
                height = near_blocks[i].size
            }
            local overlap, z,w = Physics.resolve_collisions(a, b)
            colisiones = true
            
        end
    else
        colisiones = false
    end
    debug:update(vecinos, colisiones, player)
end

function Physics.gravity_player_world(player, world, dt)

    local dx = world.center_x - player.position_x
    local dy = world.center_y - player.position_y

    local r = math.sqrt(dx^2 + dy^2)

    if r < 1 then r = 1 end

    

    --[[La fuerza de la gravedad se descompone en Fx y Fy para permitir el control de
    las velocidades y de sus respectivas posiciones.
    ]]

    local r_min = world.radius*8
    if r > r_min then
        local f = (G * world.mass * player.mass) / (r^2)
        local fx = f * (dx / r)
        local fy = f * (dy / r)

        player.speed_x = player.speed_x + fx * dt
        player.speed_y = player.speed_y + fy * dt

        player.position_x = player.position_x + player.speed_x * dt
        player.position_y = player.position_y + player.speed_y * dt
    else
        player.position_x = player.position_x 
        player.position_y = player.position_y


        player.speed_x = 0
        player.speed_y = 0
    end 
end



function Physics.blocks_player_collision(player, block)
    local overlap, shift_b_x, shift_b_y = Physics.resolve_collisions(player,block)

    if overlap then
        player.speed_x = 0
        player.speed_y = 0
        player.position_x = player.position_x -shift_b_x
        player.position_y = player.position_y -shift_b_y
    end
end



function Physics.resolve_collisions(a,b)
    local overlap = false
    local shift_b_x, shift_b_y = 0, 0
    if a.x + a.width < b.x or b.x + b.width < a.x or 
    a.y + a.height< b.y or b.y + b.height < a.y then
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
    colisiones = overlap
    return overlap, shift_b_x, shift_b_y
end

function Physics.near_blocks_to_player(player, world)
    local nearBlocks = {}
    local diameter = world.radius * 2
    local detection_range = 0 --10px de distancia para sacar los bloques

    local player_left   = player.position_x - detection_range
    local player_right  = player.position_x + player.width + detection_range
    local player_top    = player.position_y - detection_range
    local player_bottom = player.position_y + player.height + detection_range

    for y = 1, diameter do
        for x = 1, diameter do
            if world.planet[y][x] ~= nil and world.planet[y][x].type == 1 then
                local block = world.planet[y][x]
                local block_left   = block.position_x
                local block_right  = block.position_x + block.size
                local block_top    = block.position_y
                local block_bottom = block.position_y + block.size

                if block_right > player_left and block_left < player_right and
                    block_bottom > player_top and block_top < player_bottom then
                        --print("Bloque cerca en ("..block_left..", "..block_top..")")
                        table.insert(nearBlocks, block)
                end
            end
        end
    end
    return nearBlocks
end

return Physics