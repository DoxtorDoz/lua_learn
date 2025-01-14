local tf = require "/utils/textfield"
local bt = require "/utils/button"

local menu = {}
menu.__index = menu
menu.buttons = {}
menu.textfields = {}
menu.opciones = 0




function menu.load()
    menu.usuario = tf.new("Nombre",30, 50, 200, 30)
    table.insert(menu.textfields, menu.usuario)
    
    table.insert(menu.buttons, bt.new(350,320,100,40,"Comenzar",function ()
        menu.opciones = 1
    end))

    table.insert(menu.buttons, bt.new(365,370,70,40,"Salir",function ()
        menu.opciones = -1
    end))
end

function menu.new()
    
end

function menu.update()
    --[[  for _, button in ipairs(menu.buttons) do
        button:update()
    end ]]
    bt.updateAll(menu.buttons)

    tf.updateAll(menu.textfields)
end

function menu.draw()
    bt.drawButtons(menu.buttons)
    tf.drawTextFields(menu.textfields)
    love.graphics.printf( "Arkanoide :D\n" ..
    "Arkanoide en Lua y Love2D\n"..
    "Pulsa [Enter] para comenzar",
    300, 250, 200, "center" )
end

--[[ function love.textinput(t)
    tf.textInputAll(menu.textfields, t)
end ]]

return menu