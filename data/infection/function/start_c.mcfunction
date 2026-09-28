# INFECTION start
## if eligible


# announce
title @a title {"text":"INFECTION","color":"green"}
title @a subtitle {"text":"You have 5 minutes to prepare before a random player is infected!","color":"white"}
tellraw @a ["",{"text":"[","color":"dark_gray"},{"text":"!","color":"green","bold":true},{"text":"] ","color":"dark_gray"},{"text":"The game has started!","color":"yellow"}]
# sfx
execute as @a at @s run playsound entity.generic.explode player @s ~ ~ ~
execute as @a at @s run playsound block.note_block.pling player @s ~ ~ ~

# world
worldborder set 1000 10
schedule function infection:system/border/close 10s
team join alive @a[gamemode=!spectator]

# set period
scoreboard players set period internal 0