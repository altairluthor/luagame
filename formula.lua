local module = {}

math.randomseed(tostring(os.time()):reverse():sub(1, 7))

function module.calDamage(atk, def, adj)
    adj = adj or 0
    return atk * (1 - 0.1 + math.random() * 0.2) - def + adj
end

return module
