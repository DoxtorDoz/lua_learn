local tf = require "/utils/textfield"
local label  = require "/utils/label"

local menu = {}

function menu.load()
    tf.values(200, 200, 200, 30)
    
end

function menu.update()
    
end

function menu.draw()
    --label.draw("Nombre:",200, 200)
    tf.draw_with_label("Nombre", 200, 200, 100, 30)
    love.graphics.printf( "Arkanoide :D\n" ..
    "Arkanoide en Lua y Love2D\n"..
    "Pulsa [Enter] para comenzar",
    300, 250, 200, "center" )
end

return menu