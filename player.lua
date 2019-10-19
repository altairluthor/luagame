local Formula = require('formula')

local module = {}

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
	self.maxHealth = self.health
	return player
end

function module.Player:handleBeAttack(atk)
	local damage = Formula.calDamage(atk, self.defence)
	print(self.name..'受到了'..damage..'点伤害，乂(ﾟДﾟ三ﾟДﾟ)乂 ')
	self.health = self.health - damage
end

function module.Player:useSkill()
	return self.skill
end

function module.Player:levelUp()
	self.level = self.level + 1
	self.attack = self.attack * 1.05
	self.defence = self.defence * 1.05
	self.experience = 0
	self.health = self.maxHealth
	print(self.name..'等级提升，(σﾟ∀ﾟ)σ')
	return self.skill
end

return module