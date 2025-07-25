local platform = {}
platform.position_x = 500
platform.position_y = 500
platform.speed_x = 400

platform.width  = 140
platform.height = 20


function platform.update(dt)
    if love.keyboard.isDown("right") or love.keyboard.isDown('d') then
        platform.position_x = platform.position_x + (platform.speed_x * dt)
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
        platform.position_x = platform.position_x - (platform.speed_x * dt)
    end
end


function platform.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle('line',
        platform.position_x,
        platform.position_y,
        platform.width,
        platform.height)
end

return platform