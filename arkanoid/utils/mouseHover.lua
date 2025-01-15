local mouseHover  = {}

function mouseHover.check(x, y, w, h)
    
    local mouseX, mouseY = love.mouse.getPosition()
    local isHovered = ( mouseX > x and mouseX <= x + w )
        and ( mouseY > y and mouseY <= y + h )
        return isHovered
end

return mouseHover