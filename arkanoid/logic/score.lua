local score = {}
score.score = 0
local score_font = love.graphics.newFont(20)

function score.load()
    local score_font = love.graphics.newFont(20)
end

function score.draw()
    love.graphics.setFont(score_font)
    love.graphics.printf("Score\n"..score.score, 550, 20,200,"right")
end

function score.update()
end

function score.incrementScore(brick)
    score.score = score.score + brick * 10
    return score
end

return score