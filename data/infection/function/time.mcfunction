# INFECTION time


execute if score period internal matches 0..2 run function fm:clock

# periods
## starter period
execute if score period internal matches 0 if score time_s internal >= starter_period internal run function infection:system/period/main

# time left
## starter period (0)
execute if score period internal matches 0 run scoreboard players operation time_left internal = starter_period internal
execute if score period internal matches 0 run scoreboard players operation time_left internal -= time_s internal

# worldborder
execute store result score border internal run worldborder get

# bossbar
execute unless score period internal matches 2 store result bossbar infection:main value run scoreboard players get time_s internal
## pre-game (-1)
execute if score period internal matches -1 run bossbar set infection:main name "The games will begin shortly!"
execute if score period internal matches -1 run bossbar set infection:main color white
## starter period (0)
execute if score period internal matches 0 run bossbar set infection:main name ["",{"text":"Starter period    ","color":"yellow"},{"score":{"name":"time_left","objective":"internal"},"color":"yellow","bold":true},{"text":" seconds left","color":"white"}]
execute if score period internal matches 0 run bossbar set infection:main color yellow
execute if score period internal matches 0 store result bossbar infection:main max run scoreboard players get starter_period internal
execute if score period internal matches 0 store result bossbar infection:main value run scoreboard players get time_s internal
## main period (2)
execute if score period internal matches 2 run bossbar set infection:main name ["",{"text":"INFECTION","bold":true,"color":"dark_green"},{"text":"ALIVE: ","color":"dark_green"},{"score":{"name":"alive","objective":"internal"},"bold":true,"color":"green"},{"text":"   INFECTED: ","color":"dark_green"},{"score":{"name":"infected","objective":"internal"},"bold":true,"color":"green"},{"text":"   BORDER: ","color":"dark_green"},{"score":{"name":"border","objective":"internal"},"bold":true,"color":"green"}]
execute if score period internal matches 2 run bossbar set infection:main color green
execute if score period internal matches 2 store result bossbar infection:main max run scoreboard players get victory_timeout internal
execute if score period internal matches 2 store result bossbar infection:main value run scoreboard players get time_s internal
## win (3)
execute if score period internal matches 3 run bossbar set infection:main name "Game over!"
execute if score period internal matches 3 run bossbar set infection:main color white
execute if score period internal matches 3 run bossbar set infection:main max 1
execute if score period internal matches 3 run bossbar set infection:main value 1

# last login
## pre-game (-1)
execute if score period internal matches -1 run gamemode adventure @a[gamemode=!adventure]
execute if score period internal matches -1 run effect give @a weakness 9999 255 true
execute if score period internal matches -1 run effect give @a resistance 9999 255 true
execute if score period internal matches -1 run effect give @a regeneration 9999 255 true
execute if score period internal matches -1 run effect give @a saturation 9999 255 true
execute if score period internal matches -1 run scoreboard players set @a last_login -1
## starter period (0)
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run gamemode survival @s[team=!admin,gamemode=!spectator]
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run effect clear @s weakness
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run effect give @s resistance 9999 255 true
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run effect clear @s regeneration
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run effect clear @s saturation
execute as @a if score period internal matches 0 unless score @s last_login matches 0 run scoreboard players set @s last_login 0
## main period (2)
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run gamemode survival @s[team=!admin,gamemode=!spectator]
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run effect clear @s weakness
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run effect clear @s resistance
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run effect clear @s regeneration
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run effect clear @s saturation
execute as @a if score period internal matches 2 unless score @s last_login matches 2 run scoreboard players set @s last_login 2
## win (3)
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run gamemode spectator @s[tag=!win,team=!admin]
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run effect clear @s weakness
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run effect give @s resistance 9999 255 true
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run effect clear @s regeneration
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run effect clear @s saturation
execute as @a if score period internal matches 3 unless score @s last_login matches 3 run scoreboard players set @s last_login 3