# INFECTION death


# alive -> infected
execute if entity @s[team=alive] run function infection:system/death/infect

# give infected gear
give @s stone_axe
give @s stone_pickaxe
give @s shield


scoreboard players reset @s death