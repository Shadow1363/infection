# INFECTION CUT CLEAN smelt
## run as an item entity holding a #infection:cut_clean item
## converts the item in place so the stack count is kept


particle minecraft:smoke ~ ~ ~ 0 0 0 0.01 30

# iron gives double, capped so the stack stays within 64
execute store result score cut_clean_count internal run data get entity @s Item.count
execute if items entity @s contents #infection:cut_clean_double if score cut_clean_count internal matches ..32 store result entity @s Item.count int 2 run scoreboard players get cut_clean_count internal

# ores
execute if items entity @s contents minecraft:raw_iron run data modify entity @s Item.id set value "minecraft:iron_ingot"
execute if items entity @s contents minecraft:iron_ore run data modify entity @s Item.id set value "minecraft:iron_ingot"
execute if items entity @s contents minecraft:raw_gold run data modify entity @s Item.id set value "minecraft:gold_ingot"
execute if items entity @s contents minecraft:gold_ore run data modify entity @s Item.id set value "minecraft:gold_ingot"

# food
execute if items entity @s contents minecraft:porkchop run data modify entity @s Item.id set value "minecraft:cooked_porkchop"
execute if items entity @s contents minecraft:mutton run data modify entity @s Item.id set value "minecraft:cooked_mutton"
execute if items entity @s contents minecraft:beef run data modify entity @s Item.id set value "minecraft:cooked_beef"
execute if items entity @s contents minecraft:chicken run data modify entity @s Item.id set value "minecraft:cooked_chicken"
execute if items entity @s contents minecraft:rabbit run data modify entity @s Item.id set value "minecraft:cooked_rabbit"
execute if items entity @s contents minecraft:cod run data modify entity @s Item.id set value "minecraft:cooked_cod"
execute if items entity @s contents minecraft:salmon run data modify entity @s Item.id set value "minecraft:cooked_salmon"