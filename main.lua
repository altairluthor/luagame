local Player = require('player').Player
local Monster = require('monster')

local player1 = Player:new(nil, 'Jerry', 'warriop')
local player2 = Player:new(nil, 'Tom', 'shielder')

print(player1.health, player2.health)

player1:levelUp()
print(player1.health)

local slime1 = Monster.Slime:new(nil, 'mobu', 2)
print(slime1.level, slime1.experience, slime1.skill, slime1.health, slime1.attack, slime1.defence)
