#!/bin/bash

# 定义项目根目录（请根据你的实际路径修改）
# PROJECT_ROOT="/Users/你的用户名/Documents/BLOG"
# 如果你在项目目录下直接运行脚本，可以使用下面这行自动获取路径
PROJECT_ROOT=$(pwd)

echo "🚀 开始自动化部署流程..."

# 进入项目目录
cd "$PROJECT_ROOT" || { echo "❌ 无法进入目录: $PROJECT_ROOT"; exit 1; }

# 1. 执行构建
#echo "🔨 正在运行 pnpm build..."
#if ! pnpm build; then
#  echo "❌ 构建失败，请检查错误。"
#  exit 1
#fi

# 2. 添加所有更改的文件到暂存区
echo "📦 正在添加文件到暂存区..."
git add .

# 3. 获取当前时间作为提交信息
# 格式示例: 2026-03-11 21:30:45
COMMIT_MESSAGE="chore: 自动部署 $(date '+%Y-%m-%d %H:%M:%S')"

echo "📝 正在提交更改: $COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

# 4. 推送到远程仓库
echo "🚀 正在推送到 GitHub..."
if ! git push -u origin main; then
  echo "❌ 推送失败。如果是第一次推送或有冲突，请先手动处理（如 git pull）。"
  exit 1
fi

echo "🎉 部署流程完成！"
