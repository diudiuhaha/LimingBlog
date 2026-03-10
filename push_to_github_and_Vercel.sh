#!/bin/bash

# 启用严格模式，如果任何命令失败则立即退出
set -e

echo "🚀 开始博客更新流程..."

# 1. 清理缓存并重新生成静态文件
echo "🧹 正在清理并生成文件..."
hexo clean && hexo generate

# 2. 获取最新的文章标题作为提交信息
# 这里假设你的文章都在 source/_posts 目录下
# 如果 _posts 目录为空或出错，使用默认信息
POST_TITLE=$(ls source/_posts/ | sort -r | head -n 1 | sed 's/\.[^.]*$//' 2>/dev/null)

if [ -z "$POST_TITLE" ]; then
    COMMIT_MSG="docs: 更新博客内容 $(date '+%Y-%m-%d %H:%M:%S')"
else
    COMMIT_MSG="feat: 发布新文章《$POST_TITLE》 $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 3. 推送到 GitHub
echo "📦 正在提交到 GitHub..."
echo "提交信息: $COMMIT_MSG"

git add .
git commit -m "$COMMIT_MSG"
git push origin main

echo "🎉 博客更新推送完成！Vercel 正在自动部署..."
