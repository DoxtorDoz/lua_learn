local tf = require "/utils/textfield"
local bt = require "/utils/button"

local menu = {}
menu.__index = menu
menu.buttons = {}
menu.opciones = 0


function menu.load()
    tf.values(200, 200, 200, 30)
    table.insert(menu.buttons, bt.new(100,100,100,40,"Comenzar",function ()
        menu.opciones = 1
    end))

    table.insert(menu.buttons, bt.new(100,200,100,40,"Salir",function ()
        menu.opciones = -1
    end))
end

function menu.new()
    
end

function menu.update()
    for _, button in ipairs(menu.buttons) do
        button:update()
    end
end

function menu.draw()
    bt.drawButtons(menu.buttons)
    --label.draw("Nombre:",200, 200)
    tf.draw_with_label("Nombre", 10, 40, 100, 30)
    love.graphics.printf( "Arkanoide :D\n" ..
    "Arkanoide en Lua y Love2D\n"..
    "Pulsa [Enter] para comenzar",
    300, 250, 200, "center" )
end

return menu