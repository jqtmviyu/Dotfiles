#!/bin/sh

nvim_command="/usr/local/bin/nvim"

# 如果传递了文件或目录参数，则设置目标和工作目录
if [ -n "$1" ]; then
  target="$1"

  if [ -d "$1" ]; then
    working_directory="$1"
  else
    working_directory=$(dirname "$1")
  fi
else
  target=""
  working_directory="$HOME"
fi

# 检查是否有正在运行的 Kitty 实例
sock=$(ls /tmp | grep '^kitty')

if [ -n "$sock" ]; then
  # 如果有正在运行的 Kitty 实例，在新窗口中打开 Neovim
  sock_path="unix:/tmp/$sock"
  /usr/local/bin/kitty @ --to $sock_path launch \
    --title Neovim \
    --type os-window \
    --cwd "$working_directory" \
    --no-response \
    "$nvim_command" ${target:+$target} &&
    open -a kitty
else
  # 如果没有正在运行的 Kitty 实例，启动一个新的 Kitty 实例并打开 Neovim
  open -na Kitty --args --directory "$working_directory" \
    --title "Neovim" \
    "$nvim_command" ${target:+$target}
fi
