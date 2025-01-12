local score = require "/logic/score"

local game_over = {}

function game_over.draw()
    love.graphics.printf( "Game over!\n" ..
    "You have lost to the game!",
    300, 250, 200, "center" )

    love.graphics.printf( "Score: " ..score.score,
    300, 350, 200, "center" )
end

return game_over