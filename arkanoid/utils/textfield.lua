local label = require "/utils/label"
local hover = require "/utils/mouseHover"

local TextField = {}

TextField.__index  = TextField

local focusedTextField = nil

function TextField.new(text,x,y,w,h)
    local self = setmetatable({}, TextField)
    self.position_x = x
    self.position_y = y
    self.width = w
    self.height = h
    self.text = text or ""
    self.isFocused = false
    self.isHovered = false
    self.inputText = ""
    return self
end

function TextField.drawTextFields(list)
    for _, tf in ipairs(list) do
        tf:draw()
    end
    
end


function TextField:update()
    --local mouseX, mouseY = love.mouse.getPosition()
    local mousepressed = love.mouse.isDown(1)
    self.isHovered = hover.check(self.position_x, self.position_y, self.width, self.height) 

        if self.isHovered and mousepressed then
            focusedTextField = self
            --self.isFocused = true
            focusedTextField.isFocused = true
        elseif mousepressed and not self.isHovered and focusedTextField == self then
            focusedTextField = nil
            --self.isFocused = false
        end
        
        function love.textinput(t)
            if focusedTextField then
                print("escribendo")
                focusedTextField.inputText = focusedTextField.inputText .. t
            end
        end
        function love.keypressed(key)
            if focusedTextField and key == "backspace" then
                print("eliminando caracter...")
                focusedTextField.inputText = focusedTextField.inputText:sub(1, -2)
            end

            if focusedTextField and key == "return" then
                focusedTextField = nil
            end
        end
end

function TextField.updateAll(list)
    for _, tf in ipairs(list) do
        tf:update()
    end
    
end

function TextField:draw()
    label.draw(self.text, self.position_x, self.position_y - 20)
    if self.isFocused then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end
    love.graphics.rectangle("line",
        self.position_x, 
        self.position_y,
        self.width,
        self.height)

    love.graphics.print(self.inputText, self.position_x + 10, self.position_y + self.height/3)
end



function TextField:getTexto()
    print("texto entregado")
    print(self.inputText)
    return self.inputText or "Anonimo"
end

return TextField