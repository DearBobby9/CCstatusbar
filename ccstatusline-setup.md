# Claude Code Statusline 配置指南

> 使用 [ccstatusline](https://github.com/sirmalloc/ccstatusline) 打造好看又实用的 Claude Code 状态栏

## 效果预览

```
Model: Opus 4.6 (1M context) | cwd: .../Personal_project/DisplayOS |  ⎇ main +3 -1  |         Thinking: max | Session: 29m
Context: [██████░░░░░░░░░░] 82k/1000k (8%) | Ctx: 8.0% | Cost: $3.28 | Out: 41.2 t/s      Session: 0.0% | Weekly: 17.0% | Reset: 4hr 53m
```

---

## 安装（3 步）

### Step 1: 安装 ccstatusline

```bash
npx -y ccstatusline@latest
```

运行后会：
- 自动生成配置文件 `~/.config/ccstatusline/settings.json`
- 启动交互式 TUI 界面（键盘操作，可视化配置 widget）

> 用 Bun 更快：`bunx -y ccstatusline@latest`

### Step 2: 配置 Claude Code

编辑 `~/.claude/settings.json`，加上或替换 `statusLine` 字段：

```json
{
  "statusLine": {
    "type": "command",
    "command": "npx -y ccstatusline@latest",
    "padding": 0
  }
}
```

### Step 3: 重启 Claude Code

退出重开，状态栏就生效了。

---

## 自定义配置

### 方式 A: TUI 交互界面（推荐新手）

```bash
npx -y ccstatusline@latest
```

在 TUI 里可以：
- 添加 / 删除 / 排序 widget
- 改颜色（支持 16 色、256 色、truecolor hex）
- 开关 Powerline 风格（箭头分隔符）
- 实时预览效果

### 方式 B: 直接改 JSON 配置文件

编辑 `~/.config/ccstatusline/settings.json`，格式如下：

```json
{
  "version": 3,
  "lines": [
    [
      { "id": "1", "type": "model", "color": "cyan", "bold": true },
      { "id": "2", "type": "separator" },
      { "id": "3", "type": "current-working-dir", "color": "blue" },
      { "id": "4", "type": "separator" },
      { "id": "5", "type": "git-branch", "color": "magenta" }
    ],
    [
      { "id": "10", "type": "context-bar", "color": "green" },
      { "id": "11", "type": "separator" },
      { "id": "12", "type": "session-cost", "color": "yellow" }
    ]
  ]
}
```

- `lines` 是数组的数组，每个子数组 = 一行状态栏
- 每个 widget 需要唯一 `id`、`type`（widget 类型）、`color`（颜色）

---

## 全部可用 Widget

### 基本信息

| type | 说明 |
|------|------|
| `model` | 当前模型名（如 Opus 4.6） |
| `current-working-dir` | 当前工作目录 |
| `session-clock` | 会话已持续时间 |
| `session-name` | 会话名（用 `/rename` 设置） |
| `thinking-effort` | 当前思考强度（min/low/medium/high/max） |
| `version` | Claude Code 版本号 |
| `vim-mode` | Vim 模式（NORMAL/INSERT） |

### Git 相关

| type | 说明 |
|------|------|
| `git-branch` | 当前分支名 |
| `git-changes` | 增删行数合并显示 |
| `git-insertions` | 仅新增行数（+42） |
| `git-deletions` | 仅删除行数（-10） |
| `git-root-dir` | Git 仓库根目录名 |
| `git-worktree` | 当前 worktree 名 |

> 提示：Git widget 支持 `metadata: { "hideNoGit": "true" }` 来在非 git 目录时隐藏

### Context / Token

| type | 说明 |
|------|------|
| `context-bar` | Context 使用进度条 `[██████░░░░]` |
| `context-percentage` | Context 使用百分比 |
| `context-percentage-usable` | 可用 Context 百分比（80% 上限） |
| `context-length` | Context 窗口大小 |
| `tokens-input` | 输入 token 数 |
| `tokens-output` | 输出 token 数 |
| `tokens-cached` | 缓存 token 数 |
| `tokens-total` | 总 token 数 |

### 速度 / 费用

| type | 说明 |
|------|------|
| `input-speed` | 输入 token 速度（tok/s） |
| `output-speed` | 输出 token 速度（tok/s） |
| `total-speed` | 总 token 速度（tok/s） |
| `session-cost` | 会话费用（$） |

> 速度 widget 支持 `metadata: { "window": "30" }` 设置滑动窗口秒数（0 = 全会话平均）

### 用量 / 限额

| type | 说明 |
|------|------|
| `session-usage` | 每日/会话 API 用量百分比 |
| `weekly-usage` | 每周 API 用量百分比 |
| `reset-timer` | 5 小时 block 重置倒计时 |
| `weekly-reset-timer` | 每周重置倒计时 |

### 布局 / 分隔

| type | 说明 |
|------|------|
| `separator` | 固定分隔符 `\|` |
| `flex-separator` | 弹性空白（用来右对齐后面的 widget） |
| `custom-text` | 自定义文本（支持 emoji） |
| `custom-command` | 执行自定义 shell 命令并显示结果 |
| `link` | 可点击的终端超链接（OSC 8） |

---

## 可用颜色

基础 16 色：`black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`, `brightBlack`, `brightRed`, `brightGreen`, `brightYellow`, `brightBlue`, `brightMagenta`, `brightCyan`, `brightWhite`

256 色和 truecolor 在 TUI 里可以直接输入 ANSI code 或 hex 值（如 `#cba6f7`）。

---

## 布局技巧

### 左右分区

用 `flex-separator` 实现右对齐：

```json
[
  { "type": "model", "color": "cyan" },
  { "type": "separator" },
  { "type": "git-branch", "color": "magenta" },
  { "type": "flex-separator" },
  { "type": "session-clock", "color": "brightBlack" }
]
```

效果：`Model: Opus | ⎇ main                    Session: 12m`

### 多行布局

`lines` 里加多个数组：
- Line 1: 身份/环境信息（Model, CWD, Git）
- Line 2: 指标/经济信息（Context, Cost, Speed, Usage）

### Widget 合并

设置 `"merge": true` 让相邻 widget 不加分隔符紧贴显示，适合 git insertions + deletions 合在一起。

---

## 测试命令

不用启动 Claude Code 也能测试效果：

```bash
echo '{"model":{"display_name":"Opus"},"context_window":{"used_percentage":35},"cost":{"total_cost_usd":0.42}}' | npx -y ccstatusline@latest
```

---

## 相关链接

- [ccstatusline GitHub](https://github.com/sirmalloc/ccstatusline)
- [Claude Code 官方 statusline 文档](https://docs.anthropic.com/en/docs/claude-code/statusline)
- [其他社区方案](https://github.com/hesreallyhim/awesome-claude-code)
