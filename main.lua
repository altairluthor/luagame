local Player = require('player').Player

local player1 = Player:new(nil, 'Jerry', 'caster')
local player2 = Player:new(nil, 'Tom', 'warriop')

player1:handleBeAttack(10)
print(player1.health, player2.health)

player1:levelUp()
print(player1.health)
