local Button = {}

Button.__index = Button

--TODO: Hacer que onClick sea una lista para poder tener 3 posibles acciones para cada boton del raton
function Button.new(x, y, w, h, text, onClick)
    local self = setmetatable({}, Button)
    self.position_x = x
    self.position_y = y
    self.width = w
    self.height = h
    self.text = text
    self.onClick = onClick or  function () print("click") end
    self.isHovered = false
    return self
end

function Button.drawButtons(list)
    for _, button in ipairs(list) do
        button:draw()
    end
end


function Button:draw()
    love.graphics.rectangle("line", self.position_x, self.position_y, self.width, self.height)
    
    love.graphics.printf(self.text, self.position_x, self.position_y + self.height/3, self.width, "center")
end

function Button:update()
    local mouseX, mouseY = love.mouse.getPosition()
    self.isHovered = mouseX > self.position_x 
        and mouseX <= self.position_x + self.width
        and mouseY > self.position_y
        and mouseY <= self.position_y + self.height    
        if self.isHovered then
            --print("Encima")
            self:mousepressed()
        end
end

function Button.updateAll(list)
    for _, bt in ipairs(list) do
        bt:update()
    end
    
end

function Button:mousepressed()
    --print("hamza")
    if love.mouse.isDown(1) then
        self.onClick()
        return
    end
    if love.mouse.isDown(2) then
        self.onClick()
        return
    end

    if love.mouse.isDown(3) then
        self.onClick()
        return
    end

    
end


return Button