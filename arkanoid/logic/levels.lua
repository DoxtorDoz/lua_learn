local levels ={}
levels.current_level = 1
levels.sequence = {}
levels.game_finished = false

levels.sequence[1] = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0 },
    { 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
    { 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 },
    { 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0 },
}


levels.sequence[2] = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1 },
    { 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0 },
    { 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0 },
    { 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0 },
    { 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
 }

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