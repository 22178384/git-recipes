#!/usr/bin/env bash
# 把当前分支变基到 origin/main 最新，保持线性历史。
set -euo pipefail
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git fetch -p
git rebase "origin/main" || { git rebase --abort; echo "变基冲突，已中止。请手动解决。"; exit 1; }
echo "分支 $BRANCH 已同步到 origin/main。"
