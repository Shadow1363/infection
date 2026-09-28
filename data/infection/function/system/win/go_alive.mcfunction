# INFECTION win
## alive


scoreboard players set period internal 3

# announce
title @a title {"text":"GAME OVER!","color":"green","bold":true}
title @a subtitle {"text":"The survivors have won!","color":"yellow"}
tellraw @a ["",{"text":"[","color":"dark_gray"},{"text":"!","color":"green","bold":true},{"text":"] ","color":"dark_gray"},{"text":"The survivors have won!","color":"yellow"}]
# sfx
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~

# fireworks
effect give @a resistance 9999 255 true
execute as @a at @s run summon firework_rocket ~ ~1 ~ {FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{flight_duration:1b,explosions:[{shape:"large_ball",colors:[I;5631086],fade_colors:[I;632656],has_trail:false,has_twinkle:false}]}}}}

# effects
effect give @a[tag=win] glowing 9999 255 true