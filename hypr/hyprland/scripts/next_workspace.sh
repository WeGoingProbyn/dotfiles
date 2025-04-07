#!/usr/bin/env bash

# movetoworkspace or focusworkspace
CMD=$1

# Get list of active workspaces
ACTIVE=$(hyprctl workspaces -j | jq -r ".[] | .id" | sort -n)

# Find next workspace
NEXT=1
for ID in $ACTIVE; do
  if [[ "$ID" -eq "$NEXT" ]]; then
    ((NEXT++))
  else
    break
  fi
done

# focus on next workspace
hyprctl dispatch "$CMD" "$NEXT"
