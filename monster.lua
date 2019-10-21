-- 引入包
local Formula = require('formula')

-- 定义包
local module = {}

-- Monster怪物基础类
module.Monster = {
	name = '',
	species = 'monster',
	level = 1,
	experience = 5,
	skill = nil,
	maxHealth = 20,
	attack = 5,
	defence = 0
}

function module.Monster:new(monster, name, species, level)
	monster = setmetatable(monster or {}, self)
	self.__index = self
	monster.name = name or monster.name
	monster.species = species or monster.species
	monster.level = level or monster.level
	monster:init()
	return monster
end

function module.Monster:init(level)
	level = level or self.level
	self.experience = self.experience * (1 + 0.05 * (level - 1))
	self.health = self.maxHealth
	self.attack = self.attack * (1 + 0.05 * (level - 1))
	self.defence = self.defence * (1 + 0.05 * (level - 1))
end

function module.Monster:beAttack(atk)
	local damage = Formula.calDamage(atk, self.defence)
	print(self.species..' '..self.name..'受到了'..damage..'点伤害，(￣へ￣╬)')
	self.health = self.health - damage
	if self.health < 0 then
		return self:death()
	end
	return false
end

function module.Monster:death()
	print(self.species..' '..self.name..'再起不能 _(:ι」∠)_')
	return self.experience
end

function module.Monster:useSkill()
	return self.skill
end

-- 史莱姆子类
module.Slime = module.Monster:new({
	experience = 5,
	skill = nil,
	maxHealth = 20,
	attack = 12,
	defence = 0
}, nil, 'slime')

function module.Slime:new(slime, name, level)
	slime =  setmetatable(slime or {}, self)
	self.__index = self
	slime.name = name or slime.name
	slime.level = level or slime.level
	slime:init()
	return slime
end

-- 狼人子类
module.Werewolf = module.Monster:new({
	experience = 13,
	skill = nil,
	maxHealth = 24,
	attack = 18,
	defence = 2
}, nil, 'werewolf')

function module.Werewolf:new(werewolf, name, level)
	werewolf =  setmetatable(werewolf or {}, self)
	self.__index = self
	werewolf.name = name or werewolf.name
	werewolf.level = level or werewolf.level
	werewolf:init()
	return werewolf
end

-- 蛇怪子类
module.Basilisk = module.Monster:new({
	experience = 11,
	skill = nil,
	maxHealth = 20,
	attack = 15,
	defence = 2
}, nil, 'basilisk')

function module.Basilisk:new(basilisk, name, level)
	basilisk =  setmetatable(basilisk or {}, self)
	self.__index = self
	basilisk.name = name or basilisk.name
	basilisk.level = level or basilisk.level
	basilisk:init()
	return basilisk
end

-- 巨怪子类
module.Troll = module.Monster:new({
	experience = 25,
	skill = nil,
	maxHealth = 25,
	attack = 18,
	defence = 5
}, nil, 'troll')

function module.Troll:new(troll, name, level)
	troll =  setmetatable(troll or {}, self)
	self.__index = self
	troll.name = name or troll.name
	troll.level = level or troll.level
	troll:init()
	return troll
end

-- BOSS-深红之王子类
module.ScarletKing = module.Monster:new({
	experience = 5,
	skill = nil,
	maxHealth = 150,
	attack = 25,
	defence = 10
}, 'Scarlet King', 'boss')

function module.ScarletKing:new(king, name, level)
	king =  setmetatable(king or {}, self)
	self.__index = self
	king.name = name or king.name
	king.level = level or king.level
	king:init()
	return king
end

-- 怪物种族表
module.Species = {
	[1] = module.Slime,
	[2] = module.Werewolf,
	[3] = module.Basilisk,
	[4] = module.Troll,
	[5] = module.ScarletKing
}

return module
