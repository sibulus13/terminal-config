# Dotfiles — Open Projects

## [THEME] Crimson Noir — Custom WezTerm Theme

**Status:** In progress (base palette applied, needs refinement)
**Goal:** A fully hand-crafted WezTerm color scheme with a dark-mysterious-premium aesthetic.

### Vision
- Background: deep purple-black void (`#0e0014`)
- Primary accent: very saturated crimson-magenta (`#c4185c`)
- Secondary: regal deep purple (`#8b1aaa`)
- Feel: dark, mysterious, premium — not neon, not pastel

### Current state
Base palette is live in `wezterm/wezterm.lua` under `config.colors`.
All 16 ANSI slots assigned. Tab bar overrides in place.

### Remaining work
- [ ] Live-tune accent saturation/brightness after extended use
- [ ] Build a standalone `.toml` file so the scheme is portable / shareable
- [ ] Verify contrast ratios across all 16 ANSI pairs (WCAG AA minimum 4.5:1)
- [ ] Design palette using oklch.com for perceptual uniformity
- [ ] Consider publishing to the WezTerm color scheme gallery

### Tools
- Palette design: https://coolors.co  /  https://oklch.com
- Contrast check: https://webaim.org/resources/contrastchecker
- ANSI slot reference: slots 1=red 2=green 3=yellow 4=blue 5=magenta 6=cyan

### How to extract into a portable .toml
```toml
# ~/.config/wezterm/colors/crimson-noir.toml
[colors]
background = "#0e0014"
foreground = "#edd9f5"
# ... rest of palette

[colors.tab_bar]
# ... tab bar overrides
```
Then in wezterm.lua: `config.color_scheme = "crimson-noir"`
(WezTerm auto-discovers .toml files in the colors/ subdirectory)
