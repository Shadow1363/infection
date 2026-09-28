# INFECTION /reload


scoreboard objectives add global dummy
scoreboard objectives add internal dummy
scoreboard objectives add last_login dummy

# open setup
scoreboard objectives add setup trigger

# numbers
scoreboard players set 100 internal 100

# bossbar
bossbar add infection:main ""
bossbar set infection:main color green

# track player death
scoreboard objectives add player.death deathCount
# track player height
scoreboard objectives add player.height dummy

# teams
## alive
team add alive
team modify alive friendlyFire false
## infected
team add infected
team modify infected color green
team modify infected friendlyFire false

# defaults
execute unless score defaults internal matches 1.. run function infection:defaults