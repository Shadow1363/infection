# Upgrade plan: 1.19 (pack format 10) → Java 26.3 (data pack format 121.0)

> **Status (2026-09-28): steps 1–8 are applied.** The pack loads on a headless 26.3 server with no parse errors. Cut clean, the compass, text components, fireworks, and gamerules were checked with a scratch test pack. Step 9 (optional fixes) is not done. The step 10 checklist still needs an in-game multiplayer playtest.
>
> Deviations from the plan below:
>
> - Cut clean uses item tags (`tags/item/cut_clean*.json`) and one `extras/cut_clean/smelt` function. It keeps the old silk-touched ore → ingot conversion instead of dropping it, and only doubles iron when the stack is ≤32.
> - The compass cleanup skips `Age:0s` items. Fixing the old never-matching selector exposed a same-tick race between several infected players.
> - The ` ` escapes were replaced with literal spaces. The setup menu was converted in place and not refactored to macros.

Target: **Java Edition 26.3** (released 2026-09-15, data pack format `121.0`). 26.4 snapshots are at `122.0`; don't target them yet.

Researched against the Minecraft Wiki pack-format history and version changelogs (sources at the bottom). Items marked **(verify)** are ones where the exact field name should be confirmed in game before relying on it.

## Breaking changes that hit this pack

| Version (format) | Change                                                                                                                                                                                                                                                   | Where it hits us                                                                                                                                                                    |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.20.3 (26)      | Block/item `grass` renamed to `short_grass`; stricter text-component parsing                                                                                                                                                                             | `tags/blocks/safe.json`. An unknown entry fails the **whole tag**, so `#infection:safe` stops resolving and `main.mcfunction` fails to parse. The game tick then never runs.        |
| 1.20.5 (41)      | Item NBT (`Count`, `tag`) replaced by components (`count`, `components`)                                                                                                                                                                                 | `system/passive/compass`, `system/passive/infected` (`nbt=` inventory check), `system/win/go_*` (firework item), `extras/cut_clean` (`Count:2b`)                                    |
| 1.20.5 (41)      | `/particle` block options are now SNBT: `block{block_state:"…"}`                                                                                                                                                                                         | `system/passive/infected`                                                                                                                                                           |
| 1.20.5 (41)      | `/execute if items` added; item `nbt` predicates removed                                                                                                                                                                                                 | Use it to replace the compass `nbt=` checks and the cut-clean `name=` checks                                                                                                        |
| 1.21 (48)        | Singular folder names: `functions`→`function`, `tags/functions`→`tags/function`, `tags/blocks`→`tags/block`                                                                                                                                              | Every file in the pack. **With plural folders nothing loads.**                                                                                                                      |
| 1.21.5 (71)      | Text components in commands are SNBT, not JSON. `hoverEvent`→`hover_event` (`contents`→`value`), `clickEvent`→`click_event` (`run_command`'s `value`→`command`; the leading `/` is optional). Item `custom_name`/`lore` are components, not JSON strings | `setup/go` (every line), compass name/lore. Plain tellraw/title/bossbar JSON mostly still parses as SNBT.                                                                           |
| 1.21.6 (80)      | Clicking a `run_command` click event whose command needs permission level >0 shows a yes/no confirmation screen                                                                                                                                          | Every `setup/go` button used `/function`. **Fixed:** buttons now run `trigger setup set <N>`, dispatched by `setup/trigger` (missed in the original plan and found in playtesting). |
| 1.21.9 (88.0)    | `pack.mcmeta` uses `min_format`/`max_format`. World borders are per-dimension                                                                                                                                                                            | `pack.mcmeta`. Border commands run from the tick function (overworld), which is fine unless the game moves to another dimension.                                                    |
| 1.21.11 (94.1)   | **All gamerules renamed to snake_case** (`doImmediateRespawn`→`immediate_respawn`, `keepInventory`→`keep_inventory`)                                                                                                                                     | `defaults.mcfunction`                                                                                                                                                               |
| 26.2 (107.1)     | Team color arguments accept only lowercase with underscores                                                                                                                                                                                              | `load.mcfunction` already uses `green`, so no change needed                                                                                                                         |
| 26.1 / 26.3      | Villager trades, world clocks, new components, `/compute`, `/posteffect`                                                                                                                                                                                 | Nothing found that touches this pack                                                                                                                                                |

Unaffected: scoreboards, `trigger`, `deathCount`, `bossbar`, `team`, `worldborder` syntax, `effect give` (the 9999-second durations still work, and `infinite` has existed since 1.19.4), `enchant`, `fill … replace`, `schedule`, `playsound`, `summon firework_rocket`.

## Step-by-step plan

Do each step as its own commit. Reload after each step and check `logs/latest.log`.

### 1. Folder layout and metadata

- `git mv data/infection/functions data/infection/function`
- `git mv data/fm/functions data/fm/function`
- `git mv data/minecraft/tags/functions data/minecraft/tags/function`
- `git mv data/infection/tags/blocks data/infection/tags/block`
- `pack.mcmeta`:
  ```json
  {
    "pack": {
      "description": "Infection for 26.3\n§6YYYY.MMDD §r• §bplexion.dev",
      "min_format": 94,
      "max_format": 121
    }
  }
  ```
  94 (1.21.11) is the lowest sensible floor because of the gamerule rename. If you only want to support the current release, use `"min_format": 121`.

### 2. Block tag

In `tags/block/safe.json`, change `minecraft:grass` → `minecraft:short_grass`. Consider replacing the list with `#minecraft:replaceable` plus `water` so new plants are covered automatically.

### 3. Gamerules (`defaults.mcfunction`)

```mcfunction
gamerule immediate_respawn true
gamerule keep_inventory false
```

### 4. Text components (`setup/go.mcfunction`, the heaviest edit)

Change each option line mechanically:

- `"hoverEvent":{"action":"show_text","contents":[…]}` → `hover_event:{action:"show_text",value:[…]}`
- `"clickEvent":{"action":"run_command","value":"/function …"}` → `click_event:{action:"run_command",command:"function …"}`
- Replace ` ` escapes with literal spaces to avoid depending on SNBT escape handling.

Because each option has two near-identical lines, this is a good point to refactor into a **function macro** (1.20.2+). Render one option with `function infection:setup/option with storage infection:setup <entry>` and pass the name, key, and description in, instead of 14 hand-maintained lines. This step is optional.

The other `tellraw`/`title`/`bossbar` JSON should still parse as SNBT. Reload and check the log to confirm.

### 5. Particle (`system/passive/infected.mcfunction`)

```mcfunction
particle minecraft:block{block_state:"minecraft:lime_concrete_powder"} ~ ~0.8 ~ 0 0 0 0 2
```

### 6. Survivor compass (`system/passive/compass.mcfunction` + `infected.mcfunction`)

- Inventory check in `infected`:
  ```mcfunction
  execute unless items entity @s container.* minecraft:compass[minecraft:custom_data~{survivor_compass:1b}] unless items entity @s weapon.offhand minecraft:compass[minecraft:custom_data~{survivor_compass:1b}] at @s run function infection:system/passive/compass
  ```
- Kill dropped compasses. This also fixes the old doubly-nested `tag:{tag:…}` bug:
  ```mcfunction
  execute as @e[type=item] if items entity @s contents minecraft:compass[minecraft:custom_data~{survivor_compass:1b}] run kill @s
  ```
- Summon:
  ```mcfunction
  summon item ~ ~ ~ {PickupDelay:0s,Tags:["temp"],Item:{id:"minecraft:compass",count:1,components:{"minecraft:custom_data":{survivor_compass:1b},"minecraft:custom_name":[{text:"Survivor Compass",color:"dark_green",bold:true,italic:false},{text:" (drop to update)",italic:true}],"minecraft:lore":[{text:"Tracks the nearest survivor",color:"gray",italic:false}],"minecraft:lodestone_tracker":{tracked:false,target:{dimension:"minecraft:overworld",pos:[I;0,0,0]}}}}}
  ```
- Position writes go into the pre-seeded int array:
  `execute store result entity @e[type=item,tag=temp,limit=1] Item.components."minecraft:lodestone_tracker".target.pos[0] int 1 run data get entity @p[team=alive] Pos[0]` (repeat for `[1]`/`Pos[1]` and `[2]`/`Pos[2]`) **(verify)**.
- `data modify … Owner set from entity @s UUID` stays the same.

### 7. Fireworks (`system/win/go_alive` and `system/win/go_infected`)

```mcfunction
execute as @a at @s run summon firework_rocket ~ ~1 ~ {FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{flight_duration:1b,explosions:[{shape:"large_ball",colors:[I;5631086],fade_colors:[I;632656],has_trail:false,has_twinkle:false}]}}}}
```

**(verify)** the `has_trail`/`has_twinkle` names.

### 8. Cut clean (`extras/cut_clean.mcfunction`)

The current `name="Raw Iron"` checks depend on the server language and ignore stack size (a Fortune stack of 3 raw iron becomes 2 ingots). Convert the item in place so the count is kept:

```mcfunction
execute as @e[type=item] if items entity @s contents minecraft:raw_iron at @s run particle minecraft:smoke ~ ~ ~ 0 0 0 0.01 30
execute as @e[type=item] if items entity @s contents minecraft:raw_iron run data modify entity @s Item.id set value "minecraft:iron_ingot"
```

Repeat for gold and each food. Drop the "1.16-" ore branch: ores haven't dropped themselves without Silk Touch since 1.17. The old code gave 2× iron. If you want to keep that, double `Item.count` with `execute store result entity @s Item.count int 2 run data get entity @s Item.count` before swapping the id.

### 9. Opportunistic fixes (optional, separate commits)

- `system/death/go`: `scoreboard players reset @s death` → `player.death`.
- Create `team add admin` in `load`, or remove the `team=!admin` filters.
- Set `scoreboard players set 1 internal 1` in `load` so debug mode works.
- Replace `9999` durations with `infinite`.
- Delete unused `stuck.mcfunction`.

### 10. Verification checklist (in a fresh 26.3 world)

- [ ] `/reload`: the log has no function/tag parse errors, and `/datapack list` shows the pack enabled without an "incompatible" warning.
- [ ] Lobby: actionbar prompt shows; `/trigger setup` renders; hover text works; every toggle/± click works and plays its sound.
- [ ] `/function infection:start` with 2 players (or `debug internal 77`): title, border expands to 1000, bossbar counts down.
- [ ] Cut clean: mined iron/gold and killed animals drop smelted items with the right counts.
- [ ] Speed UHC enchants tools; grindstones are removed.
- [ ] Height limit: barriers appear above y150 when enabled.
- [ ] Infection: a random player is infected, gets a particle trail, speed, strength, saturation, and a compass that points at the nearest survivor after being dropped and picked up again.
- [ ] Killing a survivor converts them, updates the bossbar counts, and triggers health-boost stages and border shrink.
- [ ] Both win conditions fire, with the firework, glowing, and spectator switch.

## Sources

- [Pack format – Minecraft Wiki](https://minecraft.wiki/w/Pack_format)
- [Data pack – Minecraft Wiki](https://minecraft.wiki/w/Data_pack)
- [Java Edition 26.3 – Minecraft Wiki](https://minecraft.wiki/w/Java_Edition_26.3)
- [Java Edition 26.4 Snapshot 1 – Minecraft Wiki](https://minecraft.wiki/w/Java_Edition_26.4_Snapshot_1)
- [Java Edition 1.21.5 – Minecraft Wiki](https://minecraft.wiki/w/Java_Edition_1.21.5)
- [Java Edition 1.20.5 – Minecraft Wiki](https://minecraft.wiki/w/Java_Edition_1.20.5)
- [Text component format – Minecraft Wiki](https://minecraft.wiki/w/Text_component_format)
- [Minecraft 1.21.11 gamerule changes – Nodecraft](https://nodecraft.com/support/games/minecraft/general/minecraft-update-1-21-11-gamerule-changes)
