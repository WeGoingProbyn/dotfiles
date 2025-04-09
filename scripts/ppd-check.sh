#!/usr/bin/env bash

LOW_THRESHOLD=20
HIGH_THRESHOLD=50

send_notif() {
  if pgrep swaync > /dev/null; then
    notify-send "$1"
  fi
}

while true; do
  status=$(cat /sys/class/power_supply/BAT0/status)
  capacity=$(cat /sys/class/power_supply/BAT0/capacity)
  profile=$(powerprofilectl get)

  if [[ "$status" == "Charging" ]]; then
    if [[ "$profile" != "performance" ]]; then
      powerprofilectl set performance
      send_notif "Charging: PPD set to performance"
    fi
  else
    if [[ "$capacity" -le $LOW_THRESHOLD ]]; then
      if [[ "$profile" != "power-saver" ]]; then
        powerprofilectl set power-saver
        send_notif "Low battery: PPD set to power-saver"
      fi
    elif [[ "$capacity" -gt $HIGH_THRESHOLD ]]; then
      if [[ "$profile" != "performance" ]]; then
        powerprofilectl set performance
        send_notif "High battery: PPD set to performance"
      fi
    else
      if [[ "$profile" != "balanced" ]]; then
        powerprofilectl set balanced
        send_notif "Battery: PPD set to balanced"
      fi
    fi
  fi
  
  sleep 120
done
