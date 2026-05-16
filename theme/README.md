# Monokai Pro Spectrum — palette reference

Single source of truth for the desktop palette. Three files, one per config language:

| File | Format | Consumed by |
|------|--------|-------------|
| `palette.css` | GTK CSS `@define-color` | `waybar/style.css`, `wofi/style.css`, `swaync/style.css` (via `@import`) |
| `monokai.conf` | kitty `key value` | `kitty/kitty.conf` (via `include`) |
| `../hypr/hyprland/colours.conf` | Hyprland `$var = rgb(...)` | Hyprland configs |

`starship.toml` keeps inline hex (TOML has no import mechanism); update it manually if the palette changes.

## Palette

| Role | Hex | Notes |
|------|-----|-------|
| bg | `#222222` | base surface |
| bg1 | `#363537` | raised surface |
| bg2 | `#525053` | hover/border |
| fg | `#fbf8ff` | primary text |
| fg1 | `#f7f1ff` | bright text |
| fg2 | `#bab6bf` | secondary text |
| fg3 | `#8b888f` | muted text / inactive border |
| fg4 | `#69676c` | dimmest text |
| red / pink | `#fc618d` | errors, accents, pulseaudio |
| orange | `#fd9353` | warnings |
| yellow | `#fce566` | selections, highlights, cpu |
| green | `#7bd88f` | success, clock, active state |
| blue | `#5ad4e6` | links, info, network |
| purple | `#948ae3` | special, memory |
| white | `#ffffff` | pure white (rarely used) |

## Surfaces (CSS only)

These translucent layers are what makes the frosted-glass look work — Hyprland blurs whatever is behind them.

| Token | Value | Use |
|-------|-------|-----|
| `glass` | `rgba(34,34,34,0.55)` | floating panels (waybar) |
| `glass-strong` | `rgba(34,34,34,0.78)` | dense panels (wofi, swaync) |
| `card` | `rgba(255,255,255,0.04)` | per-module cards |
| `card-hover` | `rgba(255,255,255,0.08)` | hover state |
| `hairline` | `rgba(255,255,255,0.06)` | 1px borders |

## Changing the palette

1. Edit hex in `palette.css`, `monokai.conf`, and `colours.conf` (three files — keep them in sync).
2. Reload: `hyprctl reload`, `pkill waybar && waybar &`, restart kitty windows.
