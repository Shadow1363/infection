# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Minecraft Java Edition **data pack** (no build system, no tests, no code other than `.mcfunction` and JSON). It runs a Halo-style "Infection" minigame: players gather resources during a starter period, then one random player is infected and must convert every survivor before the victory timer runs out. More info: https://l.plexion.dev/infection

Targets **Java 26.3 (data pack format 121)**; `pack.mcmeta` declares `min_format` 94 (1.21.11, first version with snake_case gamerules) to `max_format` 121. It was ported from 1.19. `UPGRADE_PLAN.md` records every breaking change between those versions and how each was handled. Use modern syntax everywhere: singular folder names (`function/`, `tags/block/`), item components instead of item NBT, `execute if items` instead of `nbt=` item checks, SNBT text components (`hover_event`/`value`, `click_event`/`command`), snake_case gamerules.

## Developing / testing

There is no build, lint, or test tooling. To test a change:

1. Put the repo folder (or a symlink to it) in `<world>/datapacks/`.
2. In game: `/reload`, then check `/datapack list` shows it enabled. Parse errors in any function or tag are only reported in the server/client log (`logs/latest.log`) — a function that fails to parse is silently absent, and anything that calls it breaks.
3. Headless check without the game client: download the 26.3 `server.jar` (it needs **Java 25**), set `eula=true`, and copy the pack into `world/datapacks/`. Symlinked packs are rejected by default. Boot with `nogui` and read the log for load errors. Output of commands run inside functions is suppressed. To inspect results, have a test function write them into storage (`data modify storage t:r …`), then run `data get storage t:r` from the console. `@r`/`@p`/`@a` need real players, so full game flow still needs an in-game playtest.
4. Useful in-game commands: `/trigger setup` (options menu), `/function infection:start`, `/scoreboard players set debug internal 77` (lets a game start with <2 players), `/scoreboard players set defaults internal 0` + `/reload` (re-apply `defaults`).

Releases are zipped as `Infection.zip` (gitignored). The version is the date string in `pack.mcmeta`'s description (`§6YYYY.MMDD`); commits titled "bump version number" update it.

## Architecture

Two namespaces:
- `infection:` — the game.
- `fm:` — small shared helpers (a tick clock and a player counter).

**Entry points** (`data/minecraft/tags/function/`): `load.json` → `infection:load` (creates objectives, teams, bossbar; runs `infection:defaults` once, guarded by `defaults internal`), `tick.json` → `infection:main` (runs every tick).

**State lives entirely in scoreboards**, as fake players:
- `<name> global` — user-configurable options (`cut_clean`, `speed_uhc`, `height_limit`, `glow_last_survivor`, `infected_speed_boost`, `alive_health_boost`, `patch_grindstone_exploit`, `timer_speed`). Defaults set in `defaults.mcfunction`.
- `<name> internal` — runtime state (`period`, `time`, `time_s`, `alive`, `infected`, `victory_timeout`, `percentNN` stage latches, etc.) and constants (`100 internal`).
- Per-player: `last_login` (tracks which period's effects/gamemode a player has already received, so late joiners get synced), `player.death` (deathCount), `player.height`, `setup` (trigger).

**Game phases** are `period internal`: `-1` lobby/setup → `0` starter period (`start_c` sets it) → `2` main/infection (`system/period/main` picks `@r` as infected) → `3` game over (`system/win/*`). There is no period 1. `time.mcfunction` drives the clock (`fm:clock` increments `time_s` every `timer_speed` ticks), bossbar, and per-period player state; `main.mcfunction` dispatches options, death checks, win checks, and infected passives.

**Teams**: `alive` and `infected`. Death during period 2 → `system/death/go` moves alive players to `infected` and regears them. `system/passive/health_boost` (run as each infected player, so it runs N times per tick) recomputes infected %, and on crossing each threshold latches `percentNN`, buffs survivors, shrinks the border, and resets `time_s` with a new `victory_timeout`.

**Setup menu** (`setup/go.mcfunction`) is a hand-written `tellraw` UI. Each option has an enabled and disabled line with click events that call `setup/<option>/on|off`, which set the score and call `setup/sfx/on|off`, which re-render the menu. Adding an option means: a default in `defaults`, both tellraw lines in `setup/go`, an `on/off` pair under `setup/`, and the behavior (usually `extras/` + a guarded call in `main`).

## Gotchas

- Everything in `main`/`time` runs every tick; prefer latching with a score over repeating effect/title commands where possible.
- A block/item tag with an unknown ID (e.g. a renamed block) fails to load entirely. Every function that references it then fails to parse too, including the tick function via `#infection:safe`.
- Cut clean (`extras/cut_clean` → `extras/cut_clean/smelt`) converts item entities in place by rewriting `Item.id`, so stack counts survive. Which items it converts is driven by `tags/item/cut_clean.json` and `cut_clean_double.json`.
- The survivor compass is re-summoned whenever an infected player has none. The cleanup of dropped compasses skips `Age:0s` items so several infected players don't delete each other's new compass in the same tick.
- Known pre-existing issues: `system/death/go` resets objective `death` (should be `player.death`); team `admin` is referenced but never created; `debug` mode references a `1 internal` constant that is never set; `stuck.mcfunction` is unused.
