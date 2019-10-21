-- todo: �����������ļ����棬ʹ��ͳһ�����еķ�������
-- todo: �ش�����ӳɻ��ƣ��ش�������ָ��ʻ��ƣ�׼��ʵ��
-- �����
local Player = require('player')
local Monster = require('monster')
local Formula = require('formula')

MAXLEVEL = 40
PLAYER = {}

-- ս����
local Battle
Battle = {
    battleStart = function (player, monster)
        print('--------------------------------------')
        print('һֻҰ����'..monster.species..': '..monster.name..'������!!! ��(���`��)��')
        local result = ''
        local experience = false
        local playerResult = ''
        local behavior = 1
        while true do
            -- print(player.health,player.attack,player.defence,monster.level,monster.health,monster.attack,monster.defence)
            print('������������\nѡ��� 1��������2��������3���ر�')
            behavior = io.read('*n')
            if not behavior then
                io.read()
                behavior = 1
            end
            -- ���ù����ж����������
            if behavior ~= 2 and behavior ~= 3 then
                print(player.name..': ŷ��ŷ��!!!')
                experience = monster:beAttack(player.attack)
                if experience then
                    result = 'monster'
                    break
                end
            end
            -- ������ر���Һ��֣��򹥻���ɹ��￪ʼ�ж�
            print(monster.species..' '..monster.name..': wyyyyyy!!!')
            playerResult = player:beAttack(monster.attack, behavior)
            if playerResult == 'death' then
                result = 'player'
                break
            elseif playerResult == 'defense' then
                print('ѩ��֮��!!!')
                experience = monster:beAttack(player.attack * 0.6)
                if experience then
                    result = 'monster'
                    break
                end
            elseif playerResult == 'dodge' then
                print('��ʸ֮�ӻ�!!!')
                experience = monster:beAttack(player.attack)
                if experience then
                    result = 'monster'
                    break
                end
            else
                if behavior == 3 then
                    print('ϥ������һ��������')
                end
            end
        end
        Battle.battleEnd(result, player, experience)
        return result
    end,
    battleEnd = function(result, player, experience)
        if result == 'monster' then
            print('--ս�����--')
            print('--'..player.name..'ʣ��Ѫ��'..player.health..'--')
            player:getExperience(experience)
        end
    end
}

-- ���̿�����
local Control
Control = {
    gameStart = function()
        print('��ӭ������Ϸ������Ϸ�����ڿ���״̬������BUG���밮ϧ���ĵ��ԣ���ҵ�Ե�΢Ц��')
        print('���仰˵��ƾ����д��BUG��ΪʲôҪ�� ���أ�����')
        print('���跴������ӭ��ϵshbdhxhs@163.com\n')
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
            print('С����ɹ��߳�������(��������)�� ')
        elseif (type == 'death') then
            print('��Ϸ����')
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
        print('��ѡ��ְҵ '..proStr)
        local selectPro = ''
        while true do
            print('����������ְҵ֮һ �c(�`_�`)��')
            selectPro = io.read()
            if (Player.Profession and Player.Profession[selectPro]) then
                break
            end
        end
        print('��ϲ�㼴����Ϊһ��ΰ���'..selectPro..'����������������������������ְ�')
        local selectName = io.read()
        PLAYER = Player.Player:new(nil, selectName, selectPro)
        print('�õģ������ǵ�'..selectPro..' '..selectName..'׼����̤��ð�գ�С����֮�ð�')
        print('--��Ŀǰ��������: '..'\n--Ѫ��: '..PLAYER.health..'\n--������: '..PLAYER.attack..'\n--�˺�����: '..PLAYER.defence..'\n--����: '..PLAYER.skill..'\n--�ȼ�: '..PLAYER.level)
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
