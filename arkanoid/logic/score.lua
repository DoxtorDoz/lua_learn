local tf = require "/utils/textfield"

local score = {}
score.score = 0
score.name = ""
local score_font = love.graphics.newFont(20)

function score.load(w)
    local score_font = love.graphics.newFont(20)
    score.name = w
end

function score.draw()
    love.graphics.setFont(score_font)
    love.graphics.printf(score.name, 550, 10, 200, "right")
    love.graphics.printf("Score\n"..score.score, 550, 30,200,"right")
end

function score.update()
end

function score.incrementScore(brick)
    score.score = score.score + brick * 10
    return score.score
end

return score