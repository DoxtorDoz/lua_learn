--local score = require "/logic/score"
local data = {}

function data.save_score(score, name)
    local ppp = string.format("%s ; %s", score, name)
    love.filesystem.write("data.txt", table.concat(ppp,"\n" ))
end

return data