# INFECTION alive tracker
## given to infected, will track the nearest survivor
## originally created by Troned


# kill dropped compasses
## skip freshly summoned ones (Age 0) so multiple infected don't kill each other's new compass in the same tick
execute as @e[type=item] if items entity @s contents minecraft:compass[minecraft:custom_data~{survivor_compass:1b}] unless data entity @s {Age:0s} run kill @s
# summon a new item
execute at @s run summon item ~ ~ ~ {PickupDelay:0s,Tags:["temp"],Item:{id:"minecraft:compass",count:1,components:{"minecraft:custom_data":{survivor_compass:1b},"minecraft:custom_name":["",{text:"Survivor Compass",color:"dark_green",bold:true,italic:false},{text:" (drop to update)",italic:true}],"minecraft:lore":[{text:"Tracks the nearest survivor",color:"gray",italic:false}],"minecraft:lodestone_tracker":{tracked:false,target:{dimension:"minecraft:overworld",pos:[I;0,0,0]}}}}}

# bind to UUID
data modify entity @e[type=item,tag=temp,limit=1] Owner set from entity @s UUID
# track player on xyz
execute store result entity @e[type=item,tag=temp,limit=1] Item.components."minecraft:lodestone_tracker".target.pos[0] int 1 run data get entity @p[team=alive] Pos[0]
execute store result entity @e[type=item,tag=temp,limit=1] Item.components."minecraft:lodestone_tracker".target.pos[1] int 1 run data get entity @p[team=alive] Pos[1]
execute store result entity @e[type=item,tag=temp,limit=1] Item.components."minecraft:lodestone_tracker".target.pos[2] int 1 run data get entity @p[team=alive] Pos[2]

# remove temp tag
tag @e[type=item,tag=temp] remove temp