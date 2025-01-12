local lives = {}
lives.lives = 3


function lives.draw()
    for i = 1, lives.lives do
        local segment_in_circle = 16
        love.graphics.setColor(1,0,0)
        love.graphics.circle('line',
        600 + i*25, 
        100, 
        10,
        segment_in_circle)
    end
end

function lives.update()
    lives.draw()
end

function lives.lose_life()
    print("vida perdida")
    if lives == 0 then
        
        return
    end
    lives.lives = lives.lives - 1
    lives.update()
end
return lives