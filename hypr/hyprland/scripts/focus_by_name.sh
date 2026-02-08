#!/usr/bin/env bash

NAME=$1
CLIENT=$(hyprctl clients -j | jq -r --arg name "$NAME" '.[] | select(.class == $name)')

if [ -n "$CLIENT" ]; then
  ADDRESS=$(echo "$CLIENT" | jq -r '.address')
  hyprctl dispatch focuswindow "address:$ADDRESS"
fi



