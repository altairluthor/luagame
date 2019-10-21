-- ¶¨Òå°ü
local module = {}

math.randomseed(tostring(os.time()):reverse():sub(1, 7))

function module.calDamage(atk, def, adj)
    adj = adj or 0
    local result = atk * module.rangeRandom(0.9, 1.1) - def + adj
    if result < 0 then
        result = 0
    end
    return result
end

function module.experienceToLevelup(level, exp)
    return 50 * (1 + 0.05 * level) - exp
end

function module.probabilityRandom(probability, base)
    base = base or 100
    local r = math.random(base)
    if r > probability then
        return false
    else
        return true
    end
end

function module.rangeRandom(min, max)
    return math.random() * (max - min) + min
end

return module
