#!/usr/bin/env bash
# 删除已合并到 main 的本地分支（保留 main/master）。
set -euo pipefail
DEFAULT=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo main)
git checkout "$DEFAULT" >/dev/null 2>&1
git pull --ff-only >/dev/null 2>&1
MERGED=$(git branch --merged "$DEFAULT" | grep -vE "(\*| $DEFAULT| master| main)" || true)
if [ -z "$MERGED" ]; then
  echo "没有可清理的已合并分支。"
  exit 0
fi
echo "将删除以下已合并分支："
echo "$MERGED"
echo "$MERGED" | xargs -r git branch -d
echo "清理完成。"
