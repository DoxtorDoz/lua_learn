local label = require "/utils/label"

local TextField = {}

TextField.__index  = TextField

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

--TODO: ARREGAR PARA DEJAR DE TENER FOCUSEADO EL CAMPO DE TEXTO AL HACER CLICK O ENTER
--TODO: ANADIR TAMBIEN EL BORRADO COMO ANTES
function TextField:update()
    local mouseX, mouseY = love.mouse.getPosition()
    local mousepressed = love.mouse.isDown(1)
    self.isHovered = mouseX > self.position_x 
        and mouseX <= self.position_x + self.width
        and mouseY > self.position_y
        and mouseY <= self.position_y + self.height    
        if self.isHovered and mousepressed then
            --print("Encima")
            --self:mousepressed()
            self.isFocused = true
            function love.textinput(t)
                print("escribendo")
                self.inputText = self.inputText .. t
            end
        elseif mousepressed then
            self.isFocused = false
        end
end

function TextField.updateAll(list)
    for _, tf in ipairs(list) do
        tf:update()
    end
    
end



function TextField:draw()
    label.draw(self.text, self.position_x, self.position_y - 20)
    love.graphics.rectangle("line",
        self.position_x, 
        self.position_y,
        self.width,
        self.height)

    love.graphics.print(self.inputText, self.position_x + 10, self.position_y - self.height/3)
end

function love.keypressed(key)
    if TextField.isFocused and key == "backspace" then
        print("eliminando caracter...")
        TextField.inputText = TextField.inputText:sub(1, -2)
    end
end

function TextField:getTexto()
    print("texto entregado")
    print(self.inputText)
    return self.inputText or "Anonimo"
end

return TextField