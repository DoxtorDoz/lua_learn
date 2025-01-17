local Block = {}

Block.__index = Block

function Block.new(x,y,size,type)
    local self = setmetatable({}, Block)
    self.position_x = x
    self.position_y = y
    self.size = size
    --self.height = h
    self.type = type
    --print("hola")
    return self
end

function Block:draw()
    --print("imp bloque")
    love.graphics.setColor(255, 1, 1, self.type)
    love.graphics.rectangle("fill",
    --x * self.size + px,
    self.position_x,
    self.position_y,
    --y * self.size + py,
    self.size,
    self.size)
    
end

function Block:update(x,y,px,py)
    local mouseX, mouseY = love.mouse.getPosition()
    if self.type == 1 then
        --local position_x = x*self.size + px
        --local position_y = y*self.size + py

       
        local isHover = mouseX > self.position_x and mouseX <= self.position_x + self.size and mouseY > self.position_y and mouseY <= self.position_y + self.size
       --[[  if isHover then
            print("Encima del bloque ("..self.position_x..", "..self.position_y..")")
        end ]]
    end

    if love.mouse.isDown("2") then
        self.position_x =  x*self.size + px
        self.position_y = y*self.size + py

    end
end

return Block