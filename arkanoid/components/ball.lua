local BallExplosion = require "/utils/ball_explosion"

local ball = {}
ball.position_x = 450
ball.position_y = 450
ball.speed_x = 300
ball.speed_y = 300
ball.sticked = false

ball.radius = 10

local explosion = nil


function ball.update(dt, platform)
    if not ball.sticked then
        ball.position_x = ball.position_x + ball.speed_x * dt
        ball.position_y = ball.position_y + ball.speed_y * dt
    else
        ball.stick_to_platform(platform)
        if love.keyboard.isDown("space") then
            print("Comenzar movimiento")
            ball.sticked = false
            ball.start_move()
        end
    end

    if explosion ~= nil then
        explosion:update(dt)
        if explosion.life_span <= 0 then
            explosion = nil
        end
    end
end


function ball.draw()
    local segment_in_circle = 16
    love.graphics.setColor(1,0,0)
    love.graphics.circle('line',
        ball.position_x,
        ball.position_y,
        ball.radius,
        segment_in_circle)

        if explosion ~= nil then
            print("la explosion no es nula "..explosion.position_x)
            explosion:draw()
        end
    
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

--[[ function ball.reposition()
    ball.position_x = 450
    ball.position_y = 450
end
 ]]

function ball.stick_to_platform(platform)
    ball.sticked = true
    ball.position_x = platform.position_x + platform.width / 2
    ball.position_y = platform.position_y - 30
    ball.speed_x = 0
    ball.speed_y = 0
end

function ball.start_move()
    ball.speed_x = 300
    ball.speed_y = 300
end


function  ball.explosion()
    explosion =  BallExplosion.new(ball.position_x, ball.position_y, ball.radius)
    
end

return ball
