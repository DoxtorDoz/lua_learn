local menu = {}

function menu.update()
    
end

function menu.draw()
    love.graphics.printf( "Arkanoide :D\n" ..
    "Arkanoide en Lua y Love2D\n"..
    "Pulsa [Enter] para comenzar",
    300, 250, 200, "center" )
end

return menu