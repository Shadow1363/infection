# INFECTION setup
## dynamically generated


# tellraw
## header
tellraw @s ["",{"text":"\nINFECTION\n","color":"green","bold":true}]
## intro
tellraw @s ["",{"text":"Before the game begins, check your options and invite everyone to the game. Hover over titles for more information.\n"}]
## options
tellraw @s ["",{"text":"Options:","color":"yellow"}]

# height limit
## enabled
execute if score height_limit global matches 1.. run tellraw @s ["",{"text":"Build height limit    ","hover_event":{"action":"show_text","value":[{"text":"Limits the build height to y200."}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 10"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score height_limit global matches 1.. run tellraw @s ["",{"text":"Build height limit    ","hover_event":{"action":"show_text","value":[{"text":"Limits the build height to y200."}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 11"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

# infected speed boost
## enabled
execute if score infected_speed_boost global matches 1.. run tellraw @s ["",{"text":"Infected speed boost    ","hover_event":{"action":"show_text","value":[{"text":"Gives the infected a permanent speed boost to prevent an infinite chase!"}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 20"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score infected_speed_boost global matches 1.. run tellraw @s ["",{"text":"Infected speed boost    ","hover_event":{"action":"show_text","value":[{"text":"Gives the infected a permanent speed boost to prevent an infinite chase!"}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 21"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

# alive health boost
## enabled
execute if score alive_health_boost global matches 1.. run tellraw @s ["",{"text":"Alive health boost    ","hover_event":{"action":"show_text","value":[{"text":"Gives the alive players extra health based on the percentage infected."}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 30"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score alive_health_boost global matches 1.. run tellraw @s ["",{"text":"Alive health boost    ","hover_event":{"action":"show_text","value":[{"text":"Gives the alive players extra health based on the percentage infected."}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 31"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

# glow last survivor
## enabled
execute if score glow_last_survivor global matches 1.. run tellraw @s ["",{"text":"Glow last survivor    ","hover_event":{"action":"show_text","value":[{"text":"Gives the last remaining survivor a glowing effect."}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 40"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score glow_last_survivor global matches 1.. run tellraw @s ["",{"text":"Glow last survivor    ","hover_event":{"action":"show_text","value":[{"text":"Gives the last remaining survivor a glowing effect."}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 41"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

# timer speed
tellraw @s ["",{"text":"Timer speed    ","hover_event":{"action":"show_text","value":[{"text":"Controls the speed of the timer ticks counting seconds. (default 20 ticks -> 1 second, higher is slower)"}]}},{"text":" ","color":"white"},{"text":"-","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 50"}},{"text":"  ","color":"white"},{"score":{"name":"timer_speed","objective":"global"}},{"text":"  ","color":"dark_gray"},{"text":"+","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 51"}},{"text":" ","color":"dark_gray"}]

# cut clean
## enabled
execute if score cut_clean global matches 1.. run tellraw @s ["",{"text":"Cut Clean    ","hover_event":{"action":"show_text","value":[{"text":"Automatically smelts ores and cooks food."}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 60"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score cut_clean global matches 1.. run tellraw @s ["",{"text":"Cut Clean    ","hover_event":{"action":"show_text","value":[{"text":"Automatically smelts ores and cooks food."}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 61"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

# speed uhc
## enabled
execute if score speed_uhc global matches 1.. run tellraw @s ["",{"text":"Speed UHC    ","hover_event":{"action":"show_text","value":[{"text":"Automatically enchants tools with efficiency."}]}},{"text":"[","color":"white"},{"text":"✔","color":"green","bold":true},{"text":"]","color":"white"},{"text":"  ","color":"dark_gray"},{"text":"X","color":"red","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 70"}},{"text":" ","color":"dark_gray"}]
## disabled
execute unless score speed_uhc global matches 1.. run tellraw @s ["",{"text":"Speed UHC    ","hover_event":{"action":"show_text","value":[{"text":"Automatically enchants tools with efficiency."}]}},{"text":" ","color":"dark_gray"},{"text":"✔","color":"green","bold":true,"click_event":{"action":"run_command","command":"trigger setup set 71"}},{"text":" ","color":"dark_gray"},{"text":" [","color":"white"},{"text":"X","color":"red","bold":true},{"text":"]","color":"white"}]

## footer
tellraw @s ["",{"text":"\nOnce you're ready, run "},{"text":"/function infection:start","color":"yellow","underlined":true,"click_event":{"action":"run_command","command":"trigger setup set 100"}},{"text":" and let the games begin!\n"}]


scoreboard players set setup internal 1