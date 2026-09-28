# clock loop
## modified to fit purpose


scoreboard players add time internal 1

execute if score time internal >= timer_speed global run scoreboard players add time_s internal 1
execute if score time internal >= timer_speed global run scoreboard players set time internal 0