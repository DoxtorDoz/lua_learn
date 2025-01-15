local data = require "/logic/data"
local Game = {}


Game.__index = Game

function  Game.new()
    local self = setmetatable({}, Game)
    self.data = data.load_scores() or {}
    self.max_score, self.max_name = self:getMaxScore(self.data)
    return self
end

function Game:getMaxScore(data)
    local max_score = 0
    local max_name = ""
    for _, entry in ipairs(data) do
        if entry.score > max_score then
            max_score = entry.score
            max_name = entry.name
        end
    end

    return max_score, max_name
end

return Game