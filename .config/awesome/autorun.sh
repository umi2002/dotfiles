#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "discord"
run "spotify"
run "thunderbird"
run "flameshot"
run "picom"
