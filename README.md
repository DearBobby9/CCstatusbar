# CCstatusbar

A two-line, responsive Claude Code statusline configuration powered by [ccstatusline](https://github.com/sirmalloc/ccstatusline).

## Screenshot

<!-- Replace with your own screenshot -->
![CCstatusbar Screenshot](assets/screenshot.png)

```
Line 1: Model: Opus 4.6 (1M context) | cwd: .../Personal_project/DisplayOS | ⎇ main +3 -1 |       Thinking: max | Session: 29m
Line 2: Context: [██████░░░░░░░░░░] 82k/1000k (8%) | Ctx: 8.0% | Cost: $3.28 | Out: 41.2 t/s   Session: 0.0% | Weekly: 17.0% | Reset: 4hr 53m
```

## Features

### Line 1 — Identity & Environment (left-right split)

| Left | Right |
|------|-------|
| Model name (bold cyan) | Thinking effort level |
| Working directory (3 segments) | Session duration |
| Git branch + insertions/deletions | |
| Git worktree name | |

### Line 2 — Metrics & Economics (left-right split)

| Left | Right |
|------|-------|
| Context progress bar | Session API usage % |
| Context percentage | Weekly API usage % |
| Session cost ($) | 5h block reset countdown |
| Output speed (tok/s, 30s window) | |

### Responsive Layout

Uses `full-until-compact` mode:
- **Context < 60%**: full terminal width (no truncation)
- **Context >= 60%**: reserves 40 chars for Claude Code's auto-compact message

### Smart Git Display

Git widgets auto-hide when not in a git repository (`hideNoGit: true`).

---

## Quick Install (3 steps)

### Step 1: Install ccstatusline

```bash
npx -y ccstatusline@latest
```

> Faster with Bun: `bunx -y ccstatusline@latest`

### Step 2: Copy the config

```bash
# Download and apply the settings
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/settings.json \
  -o ~/.config/ccstatusline/settings.json
```

Or manually copy [`settings.json`](settings.json) to `~/.config/ccstatusline/settings.json`.

### Step 3: Configure Claude Code

Add this to `~/.claude/settings.json`:

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

## One-liner Install

```bash
npx -y ccstatusline@latest && \
curl -fsSL https://raw.githubusercontent.com/DearBobby9/CCstatusbar/main/settings.json \
  -o ~/.config/ccstatusline/settings.json && \
echo "CCstatusbar installed! Restart Claude Code to see it."
```

> Note: You still need to add the `statusLine` config to `~/.claude/settings.json` manually (Step 3 above).

---

## Customization

### Option A: Interactive TUI

```bash
npx -y ccstatusline@latest
```

Visual editor — add/remove/reorder widgets, change colors, toggle Powerline mode, preview in real-time.

### Option B: Edit JSON directly

Edit `~/.config/ccstatusline/settings.json`. See the full widget reference in [`ccstatusline-setup.md`](ccstatusline-setup.md).

### Test without Claude Code

```bash
echo '{"model":{"display_name":"Opus"},"context_window":{"used_percentage":35},"cost":{"total_cost_usd":0.42}}' \
  | npx -y ccstatusline@latest
```

---

## All Available Widgets

<details>
<summary>Click to expand full widget list</summary>

### Basic Info
| type | Description |
|------|-------------|
| `model` | Current model name |
| `current-working-dir` | Working directory |
| `session-clock` | Session duration |
| `session-name` | Session name (via `/rename`) |
| `thinking-effort` | Thinking effort level |
| `version` | Claude Code version |
| `vim-mode` | Vim mode (NORMAL/INSERT) |

### Git
| type | Description |
|------|-------------|
| `git-branch` | Current branch |
| `git-changes` | Combined insertions + deletions |
| `git-insertions` | Lines added (+42) |
| `git-deletions` | Lines removed (-10) |
| `git-root-dir` | Repo root directory name |
| `git-worktree` | Active worktree name |

### Context / Tokens
| type | Description |
|------|-------------|
| `context-bar` | Visual progress bar |
| `context-percentage` | Usage percentage |
| `context-percentage-usable` | Usable context % (80% cap) |
| `context-length` | Context window size |
| `tokens-input` | Input token count |
| `tokens-output` | Output token count |
| `tokens-cached` | Cached token count |
| `tokens-total` | Total token count |

### Speed / Cost
| type | Description |
|------|-------------|
| `input-speed` | Input tok/s |
| `output-speed` | Output tok/s |
| `total-speed` | Total tok/s |
| `session-cost` | Session cost ($) |

### Usage / Limits
| type | Description |
|------|-------------|
| `session-usage` | Daily/session API usage % |
| `weekly-usage` | Weekly API usage % |
| `reset-timer` | 5h block reset countdown |
| `weekly-reset-timer` | Weekly reset countdown |

### Layout
| type | Description |
|------|-------------|
| `separator` | Pipe divider `\|` |
| `flex-separator` | Elastic space (right-align) |
| `custom-text` | Custom text (emoji supported) |
| `custom-command` | Shell command output |
| `link` | Clickable terminal hyperlink (OSC 8) |

</details>

---

## Credits

- [ccstatusline](https://github.com/sirmalloc/ccstatusline) by sirmalloc
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) by Anthropic
