#!/bin/bash
if ! command -v brillo &>/dev/null; then
  logger -t brightness "brillo is not installed"
  exit 1
fi

case "$(cat /sys/class/power_supply/AC*/online)" in
  1) brillo -u 150000 -S 100 ;;
  0) brillo -u 150000 -S 40 ;;
esac
