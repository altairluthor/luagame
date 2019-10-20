-- �����
local Player = require('player')
local Monster = require('monster')

-- ս����
local Battle
Battle = {
    battleStart = function (player, monster)
        print('--------------------------------------')
        print('һֻҰ����'..monster.species..': '..monster.name..'������!!! ��(*��`?)��')
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
                print('������')
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
        print('���仰˵��ƾ����д��BUG��ΪʲôҪ�� ���أ�����\n')
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
