local score = require "/logic/score"
local data = require "/logic/data"

local game_over = {}

function game_over.draw()
    love.graphics.printf( "Game over!\n" ..
    "You have lost to the game!",
    300, 250, 200, "center" )

    love.graphics.printf( "Score: " ..score.score,
    300, 350, 200, "center" )
end

function game_over.update(game, score, name)
    if score > game.max_score then
        data.save_score(score, name)
    end
end

return game_over