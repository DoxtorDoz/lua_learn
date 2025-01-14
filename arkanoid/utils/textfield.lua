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

--[[ function TextField:mousepressed()
    if love.mouse.isDown(1) then
        print("click")
        self.isFocused = true
    else
        self.isFocused = true
    end
end ]]

--[[ function TextField:handleInput(t)
    if self.isFocused then
        self.inputText =self.inputText .. love.textinput()
    end
    
end ]]


--[[ function  TextField.textInputAll(list, t)
    for _, tf in ipairs(list) do
        print("bye")
        tf:textinput(t)
    end
end ]]


function TextField:textInput(t)
    print("helo")
    if self.isFocused then
        self.inputText = self.inputText .. t
    end
    
end


--[[ function love.textinput(t)
    print("hamsa")
    if this.isFocused then
        TextField.inputText = TextField.inputText .. t
    end
end ]]


function love.keypressed(key)
    if TextField.isFocused and key == "backspace" then
        print("eliminando caracter...")
        TextField.inputText = TextField.inputText:sub(1, -2)
    end
end

function TextField:getTexto()
    print("texto entregado")
    return self.inputText or ""
end

return TextField