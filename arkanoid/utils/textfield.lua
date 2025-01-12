local label = require "/utils/label"

local textfield = {}
local position_x = 10
local position_y = 20
local width = 100
local height = 50


local isFocused = true
local inputText = ""

function textfield.values(x, y, w, h)
    position_x = x
    position_y = y
    width = w
    height = h
    
end

function textfield.draw_with_label(labelText, x, y, w, h)
    label.draw(labelText, position_x, position_y - 20)
    textfield.values(x,y,w,h)
    textfield.draw()

    
end

function textfield.draw()
    love.graphics.rectangle("line",
        position_x, 
        position_y,
        width,
        height)

    love.graphics.print(inputText, position_x + 10, position_y + 10)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if x > position_x and x <= position_x + width and y > position_y and y <= position_y + height then
            isFocused = true
        else
            isFocused = false
        end
    end
end

function love.textinput(t)
    if isFocused then
        inputText = inputText .. t
    end
end

function  love.keypressed(key)
    if isFocused and key == "backspace" then
        print("eliminando caracter...")
        inputText = inputText:sub(1, -2)
    end
end

function textfield.getTexto()
    print("texto entregado")
    return inputText
end
return textfield