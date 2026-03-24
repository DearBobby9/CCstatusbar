#!/bin/bash
# Compact 8-char context bar for ccstatusline custom-command widget
# Reads Claude Code JSON from stdin, outputs: [██░░░░░░] 12%
input=$(cat)
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
filled=$((used * 8 / 100))
[ "$filled" -gt 8 ] && filled=8
empty=$((8 - filled))
bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done
printf "[%s] %s%%" "$bar" "$used"
