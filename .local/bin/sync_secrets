#!/bin/bash

if bw login --check &>/dev/null; then
  export BW_SESSION=$(bw unlock --raw)
else
  export BW_SESSION=$(bw login --raw)
fi

bw get item "Secrets.qml" --session $BW_SESSION | jq --rawfile content "$HOME/.config/quickshell/Secrets.qml" '.notes = $content' | bw encode --session $BW_SESSION | bw edit item "$(bw get item 'Secrets.qml' --session $BW_SESSION | jq -r '.id')"

bw lock
