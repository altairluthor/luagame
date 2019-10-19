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
	health = 20,
	attack = 5,
	defence = 0
}

function module.Monster:new(monster, name, species, level)
	monster = setmetatable(monster or {}, self)
	self.__index = self
	monster.name = name or monster.name
	monster.species = species or monster.species
	monster.level = level or monster.level
	monster:init(level or monster.level)
	return monster
end

function module.Monster:init(level)
	level = level or self.level
	self.experience = self.experience * (1 + 0.05 * (level - 1))
	self.health = self.maxHealth * (1 + 0.05 * (level - 1))
	self.attack = self.attack * (1 + 0.05 * (level - 1))
	self.defence = self.defence * (1 + 0.05 * (level - 1))
end

function module.Monster:beAttack(atk)
	local damage = Formula.calDamage(atk, self.defence)
	print(self.species..': '..self.name..'受到了'..damage..'点伤害，(•́へ•́╬)')
	self.health = self.health - damage
	if self.health < 0 then
		return self:death()
	end
	return false
end

function module.Monster:death()
	print(self.species..': '..self.name..'再起不能 _(:ι」∠)_')
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
	health = 20,
	attack = 12,
	defence = 0
}, nil, 'slime', nil)

function module.Slime:new(slime, name, level)
	slime =  setmetatable(slime or {}, self)
	self.__index = self
	slime.name = name or slime.name
	slime.level = level or slime.level
	slime:init(slime.level)
	return slime
end

return module
