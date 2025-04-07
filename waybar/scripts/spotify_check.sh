#!/usr/bin/env bash

while true; do
	player_status=$(playerctl -p spotify status 2>/dev/null)

	if [ "$player_status" = "Playing" ]; then
		artist=$(playerctl -p spotify metadata artist)
		title=$(playerctl -p spotify metadata title)
		# Escape special characters for JSON
		artist=$(echo "$artist" | sed 's/&/&amp;/g')
		title=$(echo "$title" | sed 's/&/&amp;/g')
		echo '{"text": "'"$artist"'", "class": "custom-spotify", "alt": "'"$title"'"}'
	elif [ "$player_status" = "Paused" ]; then
		echo '{"text": "Paused", "class": "custom-spotify", "alt": "Paused"}'
  else
		echo '{"text": "Suspended", "class": "custom-spotify", "alt": "Suspended"}'
	fi
	sleep 0.5
done
