local levels ={}
levels.current_level = 1
levels.sequence = {}
levels.game_finished = false
levels.max_width = 13
levels.max_height = 8

levels.sequence[1] = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0 },
}


levels.sequence[2] = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    {0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0 },
    {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0 },
    {0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0 },
    {0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
    {0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0 },
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

levels.sequence[3] = {}

function levels.load()
    levels.sequence[3] = levels.createRandLevel()
end


function levels.createRandLevel()
    local rand = {}
    for row_i = 1, levels.max_height do
        rand[row_i] = {}
        for col_j = 1, levels.max_width do
            --TODO: Mejorar esta mierda porque no es nada random (repite el mismo patron!)
            rand[row_i][col_j] = math.random(0,1)
        end
    end
    return rand
end

function levels.switch_next_level(bricks, ball)
    if bricks.no_more_bricks then
        if levels.current_level < #levels.sequence then
            bricks.no_more_bricks = false
            levels.current_level = levels.current_level + 1
            bricks.construct_level(levels.sequence[levels.current_level])
            ball.reposition()
        elseif levels.current_level <= #levels.sequence then
            levels.game_finished = true

        end
    end
end

return levels