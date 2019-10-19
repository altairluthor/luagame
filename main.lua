-- 引入包
local Player = require('player').Player
local Monster = require('monster')

-- 战斗类
local Battle
Battle = {
    battleBegin = function (player, monster)
        print('--------------------------------------')
        print('一只野生的'..monster.species..': '..monster.name..'出现了!!! ψ(*｀ー´)ψ')
        local result = ''
        local experience = 0
        while true do
            experience = monster:beAttack(player.attack)
            if experience then
                result = 'monster'
                break
            elseif player:beAttack(monster.attack) then
                result = 'player'
                break
            else end
        end
        Battle.battleEnd(result, player, experience)
        return result
    end,
    battleEnd = function(result, player, experience)
        if result == 'monster' then
            print('--战斗结果--')
            print('--'..player.name..'剩余血量'..player.health..'--')
            player:getExperience(experience)
        end
    end
}

local player1 = Player:new(nil, 'Jerry', 'warriop')
local player2 = Player:new(nil, 'Tom', 'berserker')
local slime1 = Monster.Slime:new(nil, 'mobu', 2)

while true do
    if Battle.battleBegin(player2, slime1) == 'player' or player2.level == 2 then
        break
    end
    slime1 = Monster.Slime:new(nil, 'mobu', 2)
end
