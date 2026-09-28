# INFECTION setup trigger
## run as the player at @s, when their setup trigger is 1..
## chat buttons use /trigger (permission level 0) because since 1.21.6
## clicking a /function button makes the client ask for confirmation


# 1: open the menu (/trigger setup)
execute if score @s setup matches 1 run function infection:setup/go

# option toggles (x0 = off, x1 = on)
execute if score @s setup matches 10 run function infection:setup/height_limit/off
execute if score @s setup matches 11 run function infection:setup/height_limit/on
execute if score @s setup matches 20 run function infection:setup/infected_speed_boost/off
execute if score @s setup matches 21 run function infection:setup/infected_speed_boost/on
execute if score @s setup matches 30 run function infection:setup/alive_health_boost/off
execute if score @s setup matches 31 run function infection:setup/alive_health_boost/on
execute if score @s setup matches 40 run function infection:setup/glow_last_survivor/off
execute if score @s setup matches 41 run function infection:setup/glow_last_survivor/on
execute if score @s setup matches 50 run function infection:setup/timer_speed/down
execute if score @s setup matches 51 run function infection:setup/timer_speed/up
execute if score @s setup matches 60 run function infection:setup/cut_clean/off
execute if score @s setup matches 61 run function infection:setup/cut_clean/on
execute if score @s setup matches 70 run function infection:setup/speed_uhc/off
execute if score @s setup matches 71 run function infection:setup/speed_uhc/on

# 100: start the game
execute if score @s setup matches 100 run function infection:start