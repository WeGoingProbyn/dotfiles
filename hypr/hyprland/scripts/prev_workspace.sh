#!/usr/bin/env bash

# Get list of active workspaces
ACTIVE=$(hyprctl activeworkspace -j | grep -oP '(?<="id": )\d+')

if [ "$ACTIVE" -gt 1 ]; then
  PREV=$((ACTIVE-1))
else
  exit 0
fi

# focus on next workspace
hyprctl dispatch movetoworkspace "$PREV"
