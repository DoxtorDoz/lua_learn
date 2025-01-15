local Explosion = {}

Explosion.__index = Explosion

function Explosion.new(x, y, color, particle_count)
    local self = setmetatable({}, Explosion)
    self.position_x = x
    self.position_y = y
    self.color = color
    self.particles = {}
    self.gravity = 300
    self.life_span = 2

    for i = 1, particle_count do
        local angle = math.rad(math.random(0,360))
        local speed = math.random(100, 300)
        table.insert(self.particles, {
            x = x,
            y = y,
            vx = math.cos(angle) * speed,
            vy = math.sin(angle) * speed,
            life = self.life_span

        })
    end

    return self
end

function Explosion:update(dt)
    for _, particle in ipairs(self.particles) do
        particle.x = particle.x + particle.vx* dt
        particle.y = particle.y + particle.vy* dt

        particle.vy =particle.vy + self.gravity * dt -- Gravedad

        particle.life = particle.life - dt -- Tiempo de vida de la particula
    end

    for i = #self.particles, 1, -1 do
        if self.particles[i].life <= 0 then
            table.remove(self.particles, i)
        end
    end
end


function Explosion:draw()
    love.graphics.setColor(self.color)
    for _, particle in ipairs(self.particles) do
        love.graphics.points(particle.x, particle.y)
    end
    love.graphics.setColor(1,1,1)
end





return Explosion