# INFECTION infect
## used to infect players


# announce
tellraw @a ["",{"text":"[","color":"dark_gray"},{"text":"☠","color":"green"},{"text":"] ","color":"dark_gray"},{"selector":"@s","color":"green","bold":true},{"text":" has been infected!","color":"dark_green"}]
# sfx
execute as @a at @s run playsound minecraft:entity.zombie_villager.cure player @s

# swap teams
scoreboard players remove alive internal 1
team join infected @s
scoreboard players add infected internal 1