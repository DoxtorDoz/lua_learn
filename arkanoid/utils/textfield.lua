local label = require "/utils/label"

local textfield = {}
textfield.position_x = 10
textfield.position_y = 20
textfield.width = 100
textfield.height = 50


textfield.isFocused = true
textfield.inputText = ""

function textfield.values(x, y, w, h)
    textfield.position_x = x
    textfield.position_y = y
    textfield.width = w
    textfield.height = h
    
end

function textfield.draw_with_label(labelText, x, y, w, h)
    label.draw(labelText, textfield.position_x, textfield.position_y - 20)
    textfield.values(x,y,w,h)
    textfield.draw()

    
end

function textfield.draw()
    love.graphics.rectangle("line",
        textfield.position_x, 
        textfield.position_y,
        textfield.width,
        textfield.height)

    love.graphics.print(textfield.inputText, textfield.position_x + 10, textfield.position_y + 10)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if x > textfield.position_x and x <= textfield.position_x + textfield.width and y > textfield.position_y and y <= textfield.position_y + textfield.height then
            textfield.isFocused = true
        else
            textfield.isFocused = false
        end
    end
end

function love.textinput(t)
    if textfield.isFocused then
        textfield.inputText = textfield.inputText .. t
    end
end

function  love.keypressed(key)
    if textfield.isFocused and key == "backspace" then
        print("eliminando caracter...")
        textfield.inputText = textfield.inputText:sub(1, -2)
    end
end

function textfield.getTexto()
    print("texto entregado")
    return textfield.inputText
end
return textfield