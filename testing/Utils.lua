--[[
    Esta clase va a ayudar a tener distintas funciones para evitar el putisimo codigo duplicado
]]

local Utils = {}

--[[
    Con esta clase podemos realizar la rotacion respecto a un punto, rotando x (dx) e y (dy)
    *retornamos los puntos rotados
]]
function Utils.rotate_point(x,y, angle)
    local dx = x * math.cos(angle) - y * math.sin(angle)
    local dy = x * math.sin(angle) + y * math.cos(angle) 
    return dx, dy
end

return Utils