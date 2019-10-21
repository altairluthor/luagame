-- todo: 剧情描述用文件保存，使用统一的类中的方法引入
-- todo: 地带怪物加成机制，地带怪物出现概率机制，准备实现
-- 引入包
local Player = require('player')
local Monster = require('monster')
local Formula = require('formula')

MAXLEVEL = 40
PLAYER = {}

-- 战斗类
local Battle
Battle = {
    battleStart = function (player, monster)
        print('--------------------------------------')
        print('一只野生的'..monster.species..': '..monster.name..'出现了!!! ψ(￣ー￣)ψ')
        local result = ''
        local experience = false
        local playerResult = ''
        local behavior = 1
        while true do
            -- print(player.health,player.attack,player.defence,monster.level,monster.health,monster.attack,monster.defence)
            print('。。。。。。\n选择吧 1：攻击，2：防御，3：回避')
            behavior = io.read('*n')
            if not behavior then
                io.read()
                behavior = 1
            end
            -- 采用攻击行动，玩家先手
            if behavior ~= 2 and behavior ~= 3 then
                print(player.name..': 欧拉欧拉!!!')
                experience = monster:beAttack(player.attack)
                if experience then
                    result = 'monster'
                    break
                end
            end
            -- 防御或回避玩家后手，或攻击完成怪物开始行动
            print(monster.species..' '..monster.name..': wyyyyyy!!!')
            playerResult = player:beAttack(monster.attack, behavior)
            if playerResult == 'death' then
                result = 'player'
                break
            elseif playerResult == 'defense' then
                print('雪花之壁!!!')
                experience = monster:beAttack(player.attack * 0.6)
                if experience then
                    result = 'monster'
                    break
                end
            elseif playerResult == 'dodge' then
                print('避矢之加护!!!')
                experience = monster:beAttack(player.attack)
                if experience then
                    result = 'monster'
                    break
                end
            else
                if behavior == 3 then
                    print('膝盖中了一箭。。。')
                end
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
        print('换句话说，凭本事写的BUG，为什么要修 ￣へ￣（误）')
        print('如需反馈，欢迎联系shbdhxhs@163.com\n')
        Control.selectProfession()
        while true do
            local monster = Control.monsterAppear()
            local result = Battle.battleStart(PLAYER, monster) 
            if result == 'player' then
                Control.gameEnd('death')
                break
            elseif result == 'monster' and monster.species == 'boss' then
                Control.gameEnd('win')
                break
            else end
        end
    end,
    gameEnd = function (type)
        if (type == 'win') then
            print('小白鼠成功走出了笼子(～￣▽￣)～ ')
        elseif (type == 'death') then
            print('游戏结束')
        else end
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
        local level = math.min(PLAYER.level + math.ceil(Formula.rangeRandom(-5, 4)), MAXLEVEL)
        if level < 1 then
            level = 1
        end
        if (Formula.probabilityRandom(1 * PLAYER.level ^ 2)) then
            return Monster.ScarletKing:new(nil, nil, level)
        else
            return Monster.Species[math.ceil(Formula.rangeRandom(0, 4))]:new(nil, nil, level)
        end
    end
}

Control.gameStart()
