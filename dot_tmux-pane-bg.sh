#!/bin/sh
# Assign a unique tinted background to the current pane based on its index.
idx=$(tmux display-message -p "#{pane_index}")
case $((idx % 12)) in
  0)  bg="#1c1c24" ;;
  1)  bg="#241c1c" ;;
  2)  bg="#1c241c" ;;
  3)  bg="#24221c" ;;
  4)  bg="#1c2224" ;;
  5)  bg="#221c24" ;;
  6)  bg="#1c2420" ;;
  7)  bg="#201c24" ;;
  8)  bg="#24201c" ;;
  9)  bg="#1c2024" ;;
  10) bg="#241c20" ;;
  11) bg="#1e241c" ;;
esac
tmux set-option -p window-style "bg=$bg"
