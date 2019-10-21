-- �����
local module = {}

math.randomseed(tostring(os.time()):reverse():sub(1, 7))

-- �����˺�ֵ��ʽ
-- @param atk ������������
-- @param def �ܻ������˱���
-- @param adj ���ڳ�����˺�����ֵ
-- @param adjAdd ���ڼ������˺�����ֵ
-- @return ���ؼ����Ӧ�ܵ��˺�
function module.calDamage(atk, def, adj, adjAdd)
    adj = adj or 1
    adjAdd = adjAdd or 0
    def = math.min(def, 100)
    local result = atk * module.rangeRandom(0.9, 1.1) * (1 - def / 100) * adj + adjAdd
    if result < 0 then
        result = 0
    end
    return result
end

function module.experienceToLevelup(level, exp)
    exp = exp or 0
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
