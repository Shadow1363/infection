# INFECTION defaults


# general timings
scoreboard players set period internal -1

# internal time settings
## should be left unless you know what you're doing
scoreboard players set starter_period internal 480
## automatically set by datapack throughout
scoreboard players set victory_timeout internal 700

# extras
scoreboard players set cut_clean global 1
scoreboard players set speed_uhc global 1

# build height limit
scoreboard players set height_limit global 0
scoreboard players set height_limit_temp internal 200

# last survivor glows
scoreboard players set glow_last_survivor global 1

# infected gain speed
## see main
scoreboard players set infected_speed_boost global 1

# alive gain health boost
## see health_boost
scoreboard players set alive_health_boost global 1

# patch grindstone exploit
## introduced in 2022.0811
scoreboard players set patch_grindstone_exploit global 1

# timer speed
## default 20
scoreboard players set timer_speed global 20

# world
worldborder set 10
worldborder damage buffer 45
gamerule immediate_respawn true
gamerule keep_inventory false
difficulty peaceful


scoreboard players set defaults internal 1