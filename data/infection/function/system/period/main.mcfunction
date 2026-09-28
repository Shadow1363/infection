# INFECTION period
## starter -> main


scoreboard players set period internal 2
scoreboard players set time internal 0
scoreboard players set time_s internal 0

# infect random player
## must run before counting players
team join infected @r
tag @a[team=alive] add alive

# count players
scoreboard players set alive internal 0
scoreboard players set infected internal 0
execute as @a[team=alive] run scoreboard players add alive internal 1
execute as @a[team=infected] run scoreboard players add infected internal 1
## debug!
execute if score debug internal matches 77 run scoreboard players operation alive internal += 1 internal

# announce
title @a[team=infected] title ["",{"text":"You","bold":true,"color":"green"},{"text":" have been infected!","color":"dark_green"}]
title @a[team=!infected] title ["",{"selector":"@a[team=infected]","bold":true,"color":"green"},{"text":" has been infected!","color":"dark_green"}]
title @a subtitle "The games have begun, your actionbar will display your current role."
tellraw @a ["",{"text":"[","color":"dark_gray"},{"text":"!","color":"green","bold":true},{"text":"] ","color":"dark_gray"},{"text":"The infected has been chosen!","color":"yellow"}]
# sfx
execute as @a at @s run playsound block.note_block.pling player @s ~ ~ ~ 100 0.8
execute as @a at @s run playsound entity.lightning_bolt.impact player @s ~ ~ ~
execute as @a at @s run playsound minecraft:entity.zombie_villager.cure player @s

# scores
scoreboard players set victory_timeout internal 2500