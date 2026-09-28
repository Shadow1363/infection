# INFECTION win checks
## checks if either alive or infected have won


## alive
execute if score time_s internal >= victory_timeout internal run tag @a[team=alive] add win
execute if score time_s internal >= victory_timeout internal run function infection:system/win/go_alive
## infected
execute if score alive internal matches ..0 if score infected internal matches 1.. run tag @a[team=infected] add win
execute if score alive internal matches ..0 if score infected internal matches 1.. run function infection:system/win/go_infected