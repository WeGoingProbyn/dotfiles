#!/usr/bin/env bash

NAME=$1
# Filter out the client with class "Spotify"
CLIENT=$(hyprctl clients -j | jq -r --arg name "$NAME" '.[] | select(.class == $name)')

# If we found it, extract workspace ID and address
if [ -n "$CLIENT" ]; then
  ADDRESS=$(echo "$CLIENT" | jq -r '.address')
  hyprctl dispatch focuswindow "address:$ADDRESS"
fi



