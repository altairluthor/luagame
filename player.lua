-- 引入包
local Formula = require('formula')

-- 定义包
local module = {}

-- 职业表
module.Profession = {
	caster = {
		defaultValue = {
			health = 100,
			attack = 25,
			defence = 5
		},
		skill = 'boom'
	},
	warriop = {
		defaultValue = {
			health = 120,
			attack = 15,
			defence = 10
		},
		skill = 'boom'
	},
	berserker = {
		defaultValue = {
			health = 250,
			attack = 30,
			defence = 0
		},
		skill = 'boom'
	},
	assassin = {
		defaultValue = {
			health = 140,
			attack = 22,
			defence = 7
		},
		skill = 'boom'
	},
	shielder = {
		defaultValue = {
			health = 120,
			attack = 8,
			defence = 20
		},
		skill = 'boom'
	}
}

-- 角色类
module.Player = {
	name = '',
	profession = '',
	level = 1,
	experience = 0,
	skill = nil,
	health = 100,
	attack = 5,
	defence = 0
}

function module.Player:new(player, name, profession)
	player = setmetatable(player or {}, self)
	self.__index = self
	player.name = name
	player.profession = profession
	local professionData = module.Profession[profession] or {}
	player.skill = professionData.skill
	if professionData.defaultValue then
		for k, v in pairs(professionData.defaultValue) do
			player[k] = v
		end
	end
	player.maxHealth = player.health
	return player
end

function module.Player:beAttack(atk, behavior)
	local damage = 0
	local result = false
	if (behavior == 2) then
		damage = Formula.calDamage(atk, self.defence * 2)
		result = 'defense'
	elseif (behavior == 3) and (math.random() < 0.1) then
		damage = 0
		result = 'dodge'
	else
		damage = Formula.calDamage(atk, self.defence)
	end
	print(self.name..'受到了'..damage..'点伤害， 乂(*Д*三*Д*)乂 ')
	self.health = self.health - damage
	if self.health < 0 then
		self.death()
		result = 'death'
	end
	return result
end

function module.Player:death()
	print('你死了, o(￣^￣)o')
end

function module.Player:useSkill()
	return self.skill
end

function module.Player:getExperience(exp)
	print('--获得经验'..exp..'--')
	self.experience = self.experience + exp
	local experienceToLevelup = Formula.experienceToLevelup(self.level - 1, self.experience)
	if experienceToLevelup < 0 then
		self:levelUp()
	else
		print('--升级还剩经验'..experienceToLevelup..'--')
	end
end

function module.Player:levelUp()
	self.level = self.level + 1
	self.attack = self.attack * 1.08
	self.defence = self.defence * 1.08
	self.experience = 0
	self.health = self.maxHealth
	print('--'..self.name..'等级提升，(σ￣▽￣)σ, 目前等级'..self.level..'--')
	return self.skill
end

return module