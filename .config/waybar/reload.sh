#!/bin/bash

is_waybar_running() {
  pgrep -x "waybar" > /dev/null
}

if is_waybar_running; then
  echo "Terminating existing Waybar process..."
  pkill -x "waybar"

  if is_waybar_running; then
      echo "Failed to terminate Waybar. Forcing it to stop..."
      pkill -9 -x "waybar"
      sleep 0.5
  fi
fi

# Start Waybar
echo "Starting Waybar..."
waybar &

# Check if Waybar is running
if is_waybar_running; then
  echo "Waybar started successfully."
else
  echo "Error: Waybar failed to start."
  exit 1
fi