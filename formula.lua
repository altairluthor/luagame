-- ¶¨Òå°ü
local module = {}

math.randomseed(tostring(os.time()):reverse():sub(1, 7))

function module.calDamage(atk, def, adj)
    adj = adj or 0
    local result = atk * (1 - 0.1 + math.random() * 0.2) - def + adj
    if result < 0 then
        result = 0
    end
    return result
end

function module.experienceToLevelup(level, exp)
    return 50 * (1 + 0.05 * level) - exp
end

return module
