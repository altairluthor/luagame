-- 引入包
local Player = require('player')
local Monster = require('monster')

-- 战斗类
local Battle
Battle = {
    battleStart = function (player, monster)
        print('--------------------------------------')
        print('一只野生的'..monster.species..': '..monster.name..'出现了!!! ψ(*｀ー?)ψ')
        local result = ''
        local experience = 0
        while true do
            print(player.health,player.attack,player.defence,monster.level,monster.health,monster.attack,monster.defence)
            io.read()
            experience = monster:beAttack(player.attack)
            if experience then
                result = 'monster'
                break
            elseif player:beAttack(monster.attack) then
                result = 'player'
                break
            else
                print('。。。')
            end
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

-- 流程控制类
local Control
Control = {
    gameStart = function()
        print('欢迎进入游戏，本游戏还处于开发状态，如有BUG，请爱惜您的电脑（商业性的微笑）')
        print('换句话说，凭本事写的BUG，为什么要修 ￣へ￣（误）\n')
        Control.selectProfession()
        while true do
            local monster = Control.monsterAppear()
            if Battle.battleStart(PLAYER, monster) == 'player' then
                break
            end
        end
    end,
    selectProfession = function()
        local proStr, i = '', 1
        if Player.Profession then
            for k, v in pairs(Player.Profession) do
                proStr = proStr..i..': '..k..', '
                i = i + 1
            end
        end
        print('请选择职业 '..proStr)
        local selectPro = ''
        while true do
            print('请输入以上职业之一 ヽ(ー_ー)ノ')
            selectPro = io.read()
            if (Player.Profession and Player.Profession[selectPro]) then
                break
            end
        end
        print('恭喜你即将成为一名伟大的'..selectPro..'（棒读），接下来请输入你的名字吧')
        local selectName = io.read()
        PLAYER = Player.Player:new(nil, selectName, selectPro)
        print('好的，请我们的'..selectPro..' '..selectName..'准备好踏上冒险（小白鼠）之旅吧')
        print('--你目前的属性是: '..'\n--血量: '..PLAYER.health..'\n--攻击力: '..PLAYER.attack..'\n--伤害减免: '..PLAYER.defence..'\n--技能: '..PLAYER.skill..'\n--等级: '..PLAYER.level)
    end,
    monsterAppear = function()
        local monsterNum = #Monster.Species - 1
        local seed = math.random() * monsterNum
        if (seed > 0.01 * PLAYER.level ^ 2) then
            return Monster.Species[math.ceil(seed)]:new()
        else
            return Monster.ScarletKing:new()
        end
    end
}

Control.gameStart()
