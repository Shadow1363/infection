# INFECTION main loop


# setup
execute as @a unless score setup internal matches 1.. run function infection:setup/go
execute if score period internal matches -1 run title @a actionbar ["",{"text":"Configure the game using ","color":"yellow"},{"text":"/trigger setup","color":"gold"},{"text":" before the games begin!","color":"yellow"}]
## /trigger setup
scoreboard players enable @a setup
execute if score period internal matches -1 as @a if score @s setup matches 1.. run function infection:setup/go
execute unless score period internal matches -1 as @a if score @s setup matches 1.. run tellraw @s ["",{"text":"[","color":"dark_gray"},{"text":"X","color":"red","bold":true},{"text":"] ","color":"dark_gray"},{"text":"Setup flow can only be opened before the game has started.","color":"red"}]
execute as @a if score @s setup matches 1.. run scoreboard players reset @s setup

# world
bossbar set infection:main players @a

# ensure player is not stuck
execute if score period internal matches -1 as @a at @s unless block ~ ~1 ~ #infection:safe run tp @s ~ ~5 ~

# options
execute if score cut_clean global matches 1.. run function infection:extras/cut_clean
execute if score speed_uhc global matches 1.. run function infection:extras/speed_uhc
execute if score speed_uhc global matches 1.. if score patch_grindstone_exploit global matches 1.. run function infection:extras/grindstone
execute if score height_limit global matches 1.. run function infection:extras/height_limit

# time loop
function infection:time

# death checks
execute if score period internal matches 2 as @a at @s if score @s player.death matches 1.. run function infection:system/death/go
## reset
scoreboard players reset @a player.death

# win checks
execute if score period internal matches 2 run function infection:system/win/check

# infected passive effects
execute as @a[team=infected] at @s run function infection:system/passive/infected

# actionbar
title @a[team=alive] actionbar ["",{"text":"YOU ARE ","color":"dark_green"},{"text":"ALIVE","bold":true,"color":"green"},{"text":", SURVIVE THE INFECTED","color":"dark_green"}]
title @a[team=infected] actionbar ["",{"text":"YOU ARE ","color":"dark_green"},{"text":"INFECTED","bold":true,"color":"green"},{"text":", KILL ALL THE SURVIVORS","color":"dark_green"}]