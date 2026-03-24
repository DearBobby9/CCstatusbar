# CCstatusbar

A clean two-line Claude Code statusline configuration powered by [ccstatusline](https://github.com/sirmalloc/ccstatusline), with a compact custom context bar.

## Screenshot

<!-- Replace with your own screenshot -->
![CCstatusbar Screenshot](assets/screenshot.png)

```
Line 1: Model: Opus 4.6 (1M context) | ⎇ main | 🌲 main | Thinking: max | Session: 14hr 20m
Line 2: [█░░░░░░░] 12% | Cost: $8.50 | Out: 35.6 t/s | Session: 6.0% | Weekly: 18.0% | Reset: 1hr 4m
```

## Features

### Line 1 — Identity & Environment

| Widget | Description |
|--------|-------------|
| Model (bold cyan) | Current model name |
| Git Branch (magenta) | Current branch (auto-hides outside git repos) |
| Git Worktree (yellow) | Worktree name (auto-hides outside git repos) |
| Thinking Effort (gray) | Current thinking effort level |
| Session Clock (gray) | Session duration |

### Line 2 — Metrics & Economics

| Widget | Description |
|--------|-------------|
| Context Bar (green) | Compact 8-char progress bar `[██░░░░░░] 12%` |
| Session Cost (yellow) | Total session cost in USD |
| Output Speed (cyan) | Token output speed (30s rolling window) |
| Session Usage (green) | Daily API usage percentage |
| Weekly Usage (yellow) | Weekly API usage percentage |
| Reset Timer (gray) | 5-hour block reset countdown |

### Custom Context Bar

The built-in ccstatusline context bar is 16-32 characters wide and not configurable. This config uses a `custom-command` widget with a tiny bash script (`context-bar.sh`) that renders an 8-character bar:

```
Built-in:  [██░░░░░░░░░░░░░░] 124k/1000k (12%)   ~40 chars
Custom:    [█░░░░░░░] 12%                          ~15 chars
```

---

## Install

### Step 1: Install ccstatusline

```bash
npx -y ccstatusline@latest
```

> Faster with Bun: `bunx -y ccstatusline@latest`

### Step 2: Download config + context bar script

```bash
# Download settings
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/settings.json \
  -o ~/.config/ccstatusline/settings.json

# Download compact context bar script
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/context-bar.sh \
  -o ~/.claude/context-bar.sh
chmod +x ~/.claude/context-bar.sh
```

### Step 3: Configure Claude Code

Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y ccstatusline@latest",
    "padding": 0
  }
}
```

### Step 4: Restart Claude Code

Exit and reopen. Done.

---

## One-liner

```bash
npx -y ccstatusline@latest && \
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/settings.json -o ~/.config/ccstatusline/settings.json && \
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/context-bar.sh -o ~/.claude/context-bar.sh && \
chmod +x ~/.claude/context-bar.sh && \
echo "Done! Add statusLine config to ~/.claude/settings.json, then restart Claude Code."
```

---

## Customization

Run `npx -y ccstatusline@latest` to open the interactive TUI editor.

See [`ccstatusline-setup.md`](ccstatusline-setup.md) for the full widget reference and layout tips.

---

## Credits

- [ccstatusline](https://github.com/sirmalloc/ccstatusline) by sirmalloc
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) by Anthropic
