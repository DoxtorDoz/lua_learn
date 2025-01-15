--local score = require "/logic/score"
local data = {}

function data.save_score(score, name)
    local scores = data.load_scores() or {}
    
    table.insert(scores, {score = score, name = name})

    local lines = {}

    for _, entry in ipairs(scores) do
        table.insert(lines, string.format("%d;%s", entry.score, entry.name))
    end
    print("name: "..name..", score: "..score)
    love.filesystem.write("data.txt",table.concat(lines, "\n"))

    print("Guardando info")
end

function data.load_scores()
    if not love.filesystem.getInfo("data.txt") then
        return {}
    end
    
    local content  = love.filesystem.read("data.txt")
    local scores = {}

    for line in content:gmatch("[^\r\n]+") do
        local score, name = line:match("^(%d+);(.+)$")
        if score and name then
            table.insert(scores, {score  = tonumber(score), name = name})
        end
    end

    return scores  
end

return data