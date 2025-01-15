local BallExplosion = {}

BallExplosion.__index = BallExplosion

function BallExplosion.new(x, y, r)
    print("explosion creada")
    local self = setmetatable({}, BallExplosion)
    self.position_x = x
    self.position_y = y
    self.radius = r
    self.life_span = 0.1

    return self
end

function BallExplosion:update(dt)
    print("bola explota")
    print(self.radius)
    self.radius = self.radius + 1
    self.life_span = self.life_span - dt
end

function BallExplosion:draw()
    love.graphics.setColor(255,0,0, 127)
    love.graphics.circle("fill",self.position_x, self.position_y, self.radius,10)
end

return BallExplosion